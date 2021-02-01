import 'package:flutter/material.dart';
import 'package:linnefromice/components/common_snack_bars.dart';
import 'package:linnefromice/components/wrapper_common_background.dart';
import 'package:linnefromice/models/user.dart';
import 'package:linnefromice/services/evaluation_service.dart';
import 'package:linnefromice/services/user_service.dart';

class DeleteUserPage extends StatelessWidget {
  final userService = UserService();
  final evaluationService = EvaluationService();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WrapperCommonBackground(
        child: FutureBuilder<List<User>>(
          future: userService.findUsers(),
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.data == null) {
              return Center(child: Text("NO DATA"));
            }
            return _buildContents(snapshot);
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange.withOpacity(0.5),
        child: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  ListView _buildContents(AsyncSnapshot<List<User>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        final item = snapshot.data[index];
        return Card(
          color: Colors.deepOrange[200].withOpacity(0.5),
          child: ListTile(
            leading: IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () async {
                await evaluationService.deleteEvaluationsSelectedUser(item.id);
                await userService.deleteUser(item.id);
                ScaffoldMessenger.of(context).showSnackBar(successSnackBar());
                Navigator.of(context).pop();
              },
            ),
            title: Text(item.name, style: TextStyle(color: Colors.white)),
            trailing: Text(
              item.rating.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0
              )
            ),
          ),
        );
      },
    );
  }
}