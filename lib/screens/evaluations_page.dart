import 'dart:math';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:linnefromice/components/rated_heart.dart';
import 'package:linnefromice/components/wrapper_common_background.dart';
import 'package:linnefromice/components/wrapper_fab_circle_menu.dart';
import 'package:linnefromice/models/account.dart';
import 'package:linnefromice/models/evaluation.dart';
import 'package:linnefromice/services/account_service.dart';
import 'package:linnefromice/services/evaluation_service.dart';

// TODO: 暫定(本来はevaluationを拡張して、evaluationがAccountを保持する形にしたい)
class _EvaluationWithAccount {
  _EvaluationWithAccount({
    @required this.evaluation,
    @required this.account,
  });

  final Evaluation evaluation;
  final Account account;
}

class EvaluationsPage extends StatelessWidget {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  final evaluationService = EvaluationService();
  final accountService = AccountService();

  // TODO: Simplize
  Future<List<_EvaluationWithAccount>> _findEvaluationWithUser() async {
   final List<Evaluation> evaluations = await evaluationService.findEvaluations();
   final List<Account> users = await accountService.findAccounts();
   final Map<String, Account> userMap = Map.fromIterables(
     users.map((e) => e.id).toList(),
     users.map((e) => e).toList()
   );
   final List<_EvaluationWithAccount> results = evaluations.map((e) => _EvaluationWithAccount(
     evaluation: e,
     account: userMap[e.toUserId]
   )).toList();
   return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WrapperCommonBackground(
        child: FutureBuilder<List<_EvaluationWithAccount>> (
          future: _findEvaluationWithUser(),
          builder: (BuildContext context, AsyncSnapshot<List<_EvaluationWithAccount>> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  final _EvaluationWithAccount item = snapshot.data[index];
                  final String formattedDate = "${item.evaluation.createdDate.substring(0, 4)}/${item.evaluation.createdDate.substring(4, 6)}/${item.evaluation.createdDate.substring(6, 8)}";
                  return Card(
                    color: Colors.deepOrange[200].withOpacity(0.5),
                    child: ListTile(
                      leading: Text(
                        formattedDate,
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      title: Text(
                        "-> ${item.account.name}",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      subtitle: Center(
                        child: Row(
                          children: [
                            RatedHeart(rate: min(1, max(0, item.evaluation.rating - 0)), size: 30), // origin -> Icon(Icons.favorite, size: 30, color: rating >= 1 ? Colors.pink.withOpacity(0.5) : Colors.white)
                            RatedHeart(rate: min(1, max(0, item.evaluation.rating - 1)), size: 30),
                            RatedHeart(rate: min(1, max(0, item.evaluation.rating - 2)), size: 30),
                            RatedHeart(rate: min(1, max(0, item.evaluation.rating - 3)), size: 30),
                            RatedHeart(rate: min(1, max(0, item.evaluation.rating - 4)), size: 30),
                          ],
                        ),
                      ),
                      trailing: Text(
                        item.evaluation.rating.toString(),
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                  );
                },
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
      ),
      floatingActionButton: Builder(
        builder: (context) => WrapperFabCircularMenu(fabKey: fabKey)
      ),
    );
  }
}