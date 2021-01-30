import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:linnefromice/components/wrapper_common_background.dart';
import 'package:linnefromice/components/wrapper_fab_circle_menu.dart';
import 'package:linnefromice/models/evaluation.dart';
import 'package:linnefromice/models/user.dart';
import 'package:linnefromice/services/evaluation_service.dart';
import 'package:linnefromice/services/user_service.dart';

// TODO: 暫定(本来はevaluationを拡張して、evaluationがUserを保持する形にしたい)
class _EvaluationWithUser {
  _EvaluationWithUser({
    @required this.evaluation,
    @required this.user,
  });

  final Evaluation evaluation;
  final User user;
}

class EvaluationsPage extends StatelessWidget {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  final evaluationService = EvaluationService();
  final userService = UserService();

  // TODO: Simplize
  Future<List<_EvaluationWithUser>> _findEvaluationWithUser() async {
   final List<Evaluation> evaluations = await evaluationService.findEvaluations();
   final List<User> users = await userService.findUsers();
   final Map<String, User> userMap = Map.fromIterables(
     users.map((e) => e.id).toList(),
     users.map((e) => e).toList()
   );
   final List<_EvaluationWithUser> results = evaluations.map((e) => _EvaluationWithUser(
     evaluation: e,
     user: userMap[e.userId]
   )).toList();
   return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WrapperCommonBackground(
        child: FutureBuilder<List<_EvaluationWithUser>> (
          future: _findEvaluationWithUser(),
          builder: (BuildContext context, AsyncSnapshot<List<_EvaluationWithUser>> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  final _EvaluationWithUser item = snapshot.data[index];
                  return Card(
                    color: Colors.deepOrange[200].withOpacity(0.5),
                    child: ListTile(
                      leading: Text(item.evaluation.createdDate),
                      title: Text("-> ${item.user.name}"),
                      trailing: Text(item.evaluation.rating.toString()),
                    ),
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
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