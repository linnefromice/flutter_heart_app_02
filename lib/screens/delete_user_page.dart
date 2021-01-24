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
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                final item = snapshot.data[index];
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.close),
                    title: Text(item.name),
                    trailing: Text(item.rating.toString()),
                  ),
                );
              },
            );
          },
        )
      ),
    );
  }
}