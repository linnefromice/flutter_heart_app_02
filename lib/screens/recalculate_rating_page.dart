import 'package:flutter/material.dart';
import 'package:linnefromice/components/wrapper_common_background.dart';
import 'package:linnefromice/models/evaluation.dart';
import 'package:linnefromice/models/user.dart';
import 'package:linnefromice/services/evaluation_service.dart';
import 'package:linnefromice/services/user_service.dart';

class _RatingInformation {
  _RatingInformation({
    @required this.name,
    @required this.rating,
    @required this.newRating
  });

  final String name;
  final double rating;
  final double newRating;
}

class RecalculateRatingPage extends StatelessWidget {
  final userService = UserService();
  final evaluationService = EvaluationService();

  Future<List<_RatingInformation>> _getNewRatingList() async {
    final List<User> users = await userService.findUsers();
    final List<Evaluation> evaluations = await evaluationService.findEvaluations();
    final List<_RatingInformation> results = users.map((user) {
      final List<Evaluation> selectedEvaluations = evaluations.where((el) => el.userId == user.id).toList();
      if (selectedEvaluations.isNotEmpty) {
        final List<double> values = selectedEvaluations.map((element) => element.rating).toList();
        return _RatingInformation(
          name: user.name,
          rating: user.rating,
          newRating: values.reduce((curr, next) => curr + next) / values.length
        );
      }
    }).toList();
    results.removeWhere((element) => element == null); // remove user's element of no evaluation
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WrapperCommonBackground(
        child: FutureBuilder<List<_RatingInformation>>(
          future: _getNewRatingList(),
          builder: (BuildContext context, AsyncSnapshot<List<_RatingInformation>> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.hasData) {
              return Column(
                children: [
                  SizedBox(height: 50),
                  ElevatedButton.icon(
                    icon: Icon(Icons.done_all),
                    label: Text("EXECUTE"),
                    onPressed: () => {},
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: snapshot.data.map((e) => Card(
                        child: ListTile(
                          title: Text(e.name, style: TextStyle(fontSize: 12.0)),
                          subtitle: Text("${e.rating} -> ${e.newRating}", style: TextStyle(fontSize: 18.0)),
                        ),
                      )).toList(),
                    ),
                  )
                ],
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text("Loading ...")
                ],
              ),
            );
          },
        ),
      )
    );
  }
}