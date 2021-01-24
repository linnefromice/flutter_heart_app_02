import 'package:flutter/material.dart';
import 'package:linnefromice/components/wrapper_common_background.dart';
import 'package:linnefromice/models/user.dart';
import 'package:linnefromice/services/user_service.dart';

class DeleteUserPage extends StatelessWidget {
  final userService = UserService();
  
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
                await userService.deleteUser(item.id);
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