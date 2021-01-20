import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:linnefromice/components/wrapper_common_background.dart';

class AddUserPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _nameController = useTextEditingController();
    final _ratingController = useTextEditingController();
    final _avatarUrlController = useTextEditingController();

    return Scaffold(
      body: WrapperCommonBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Text("Add User"),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: "Name"
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                controller: _ratingController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "rating"
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                controller: _avatarUrlController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "avatarUrl"
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: RaisedButton(
                child: Text("SUBMIT"),
                onPressed: () {
                  print("${_nameController.text} / ${_ratingController.text} / ${_avatarUrlController.text}"); // TODO: debug
                },
              ),
            )
          ],
        )
      ),
    );
  }
}