import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:linnefromice/components/wrapper_common_background.dart';
import 'package:linnefromice/components/wrapper_fab_circle_menu.dart';
import 'package:linnefromice/models/evaluation.dart';
import 'package:linnefromice/services/evaluation_service.dart';

class EvaluationsPage extends StatelessWidget {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  final evaluationService = EvaluationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WrapperCommonBackground(
        child: FutureBuilder<List<Evaluation>> (
          future: evaluationService.findEvaluations(),
          builder: (BuildContext context, AsyncSnapshot<List<Evaluation>> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  final Evaluation item = snapshot.data[index];
                  return Card(
                    color: Colors.deepOrange[200].withOpacity(0.5),
                    child: ListTile(
                      leading: Text(item.createdDate),
                      title: Text("-> ${item.userId}"),
                      trailing: Text(item.rating.toString()),
                    ),
                  );
                },
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) => WrapperFabCircularMenu(fabKey: fabKey)
      ),
    );
  }
}