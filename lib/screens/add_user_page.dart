import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:linnefromice/components/wrapper_common_background.dart';
import 'package:linnefromice/models/user.dart';
import 'package:linnefromice/services/user_service.dart';

class AddUserPage extends HookWidget {
  final userService = UserService();

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
              child: _buildPageTitle(),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: _buildNameField(_nameController),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: _buildRatingField(_ratingController),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: _buildAvatarUrlField(_avatarUrlController),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: _buildSubmitButton(_nameController, _ratingController, _avatarUrlController),
            )
          ],
        )
      ),
    );
  }
  
  Text _buildPageTitle() => Text("Add User");
  
  TextField _buildNameField(TextEditingController _nameController) {
    return TextField(
      controller: _nameController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: "Name"
      ),
    );
  }
  
  TextField _buildRatingField(TextEditingController _ratingController) {
    return TextField(
      controller: _ratingController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          hintText: "rating"
      ),
    );
  }
  
  TextField _buildAvatarUrlField(TextEditingController _avatarUrlController) {
    return TextField(
      controller: _avatarUrlController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          hintText: "avatarUrl"
      ),
    );
  }

  RaisedButton _buildSubmitButton(TextEditingController _nameController, TextEditingController _ratingController, TextEditingController _avatarUrlController) {
    return RaisedButton(
      child: Text("SUBMIT"),
      onPressed: () {
        userService.createUser(
            User(
              name: _nameController.text,
              rating: int.parse(_ratingController.text),
              isFriend: false, // initial status
              avatarUrl: _avatarUrlController.text,
            )
        );
      },
    );
  }
}