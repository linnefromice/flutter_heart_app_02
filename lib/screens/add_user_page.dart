import 'package:clipboard/clipboard.dart';
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
    final _rating = useState(0);
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
              child: _buildRatingField(_rating),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: _buildAvatarUrlField(_avatarUrlController),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: _buildSubmitButton(context, _nameController, _rating.value, _avatarUrlController),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey)
                ),
                icon: Icon(Icons.arrow_back),
                label: Text("BACK"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
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

  Row _buildRatingField(ValueNotifier<int> state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text("Rating"),
        DropdownButton<int>(
          value: state.value,
          icon: Icon(Icons.arrow_downward),
          onChanged: (int value) => state.value = value,
          items: <int>[0, 1, 2, 3, 4, 5]
              .map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
        ),
      ],
    );
  }

  Row _buildAvatarUrlField(TextEditingController _avatarUrlController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: TextField(
            controller: _avatarUrlController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                hintText: "AvatarUrl"
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.crop_free),
          onPressed: () => FlutterClipboard.paste().then((value) {
            _avatarUrlController.text = value;
          }),
        ),
      ],
    );
  }

  ElevatedButton _buildSubmitButton(BuildContext context, TextEditingController _nameController, int rating, TextEditingController _avatarUrlController) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.grey)
      ),
      icon: Icon(Icons.forward),
      label: Text("SUBMIT"),
      onPressed: () {
        userService.createUser(
          User(
            name: _nameController.text,
            rating: rating,
            isFriend: false, // initial status
            avatarUrl: _avatarUrlController.text,
          )
        );
        Navigator.of(context).pop();
      },
    );
  }
}