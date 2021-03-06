import 'package:flutter/material.dart';

import '../components/common_snack_bars.dart';
import '../components/wrapper_common_background.dart';
import '../models/account.dart';
import '../services/account_service.dart';
import '../services/rating_calcuration_service.dart';

class _Contents extends StatelessWidget {
  _Contents({
    Key key,
    @required this.datas
  }) : super(key: key);

  final List<RatingInformation> datas;
  final accountService = AccountService();

  Future<void> _commitAllRecalculatedRating(
    final List<RatingInformation> datas
  ) async {
    final List<Account> users = await accountService.findAccounts();
    datas.forEach((element) => accountService.updateRating(
        element.userId,
        users.firstWhere((user) => user.id == element.userId).version,
        element.newRating
    ));
  }

  Widget _buildExecuteButton(final BuildContext context) => ElevatedButton.icon(
    icon: Icon(
      Icons.done_all,
      color: Colors.white,
    ),
    label: Text(
      "EXECUTE",
      style: TextStyle(color: Colors.white),
    ),
    style: ElevatedButton.styleFrom(
      primary: Colors.transparent,
      onPrimary: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
    ),
    onPressed: () async {
      await _commitAllRecalculatedRating(datas);
      ScaffoldMessenger.of(context).showSnackBar(successSnackBar());
      Navigator.of(context).pop();
    },
  );

  Widget _buildCard(final RatingInformation info) => Card(
    child: ListTile(
      title: Text(info.name, style: TextStyle(fontSize: 12.0)),
      subtitle: Text(
        "${info.rating} -> ${info.newRating}",
        style: TextStyle(fontSize: 18.0)
      ),
    ),
  );

  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        _buildExecuteButton(context),
        SingleChildScrollView(
          child: Column(
            children: datas.map(_buildCard).toList(),
          ),
        )
      ],
    );
  }
}

class RecalculateRatingPage extends StatelessWidget {
  final ratingCalculationService = RatingCalculationService();

  Widget _buildProgressing() => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      CircularProgressIndicator(),
      Text("Loading ...")
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WrapperCommonBackground(
        child: FutureBuilder<List<RatingInformation>>(
          future: ratingCalculationService.getNewRatingInformationList(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return Center(child: Text(snapshot.error.toString()));
            if (snapshot.hasData) return _Contents(datas: snapshot.data);
            return Center(child: _buildProgressing());
          },
        ),
      )
    );
  }
}
