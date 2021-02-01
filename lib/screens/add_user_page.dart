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
    final _descriptionController = useTextEditingController();
    final _rating = useState<double>(0);
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
              child: _buildTextField(_nameController, "Name"),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: _buildTextField(_descriptionController, "Description"),
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
              child: _buildSubmitButton(
                context,
                _nameController,
                _descriptionController,
                _rating.value,
                _avatarUrlController
              ),
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

  TextField _buildTextField(final TextEditingController _controller, final String label) {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: label
      ),
    );
  }

  Row _buildRatingField(ValueNotifier<double> state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text("Rating"),
        DropdownButton<double>(
          value: state.value,
          icon: Icon(Icons.arrow_downward),
          onChanged: (double value) => state.value = value,
          items: <double>[0, 1, 2, 3, 4, 5]
              .map<DropdownMenuItem<double>>((double value) {
            return DropdownMenuItem<double>(
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

  SnackBar _successSnackBar() => SnackBar(
    content: Text(
      "Success!!",
      textAlign: TextAlign.center,
    ),
    duration: Duration(seconds: 1),
    backgroundColor: Colors.green[200],
  );

  SnackBar _failureSnackBar() => SnackBar(
    content: Text(
      "Failure...",
      textAlign: TextAlign.center,
    ),
    duration: Duration(seconds: 1),
    backgroundColor: Colors.red[200],
  );

  ElevatedButton _buildSubmitButton(BuildContext context, TextEditingController _nameController, TextEditingController _descriptionController, double rating, TextEditingController _avatarUrlController) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.grey)
      ),
      icon: Icon(Icons.forward),
      label: Text("SUBMIT"),
      onPressed: () {
        if (_nameController.text == "" || (rating < 0 || rating > 5)) {
          ScaffoldMessenger.of(context).showSnackBar(_failureSnackBar());
          return;
        }
        userService.createUser(
          name: _nameController.text,
          description: _descriptionController.text,
          rating: rating,
          isFriend: false, // initial status
          avatarUrl: _avatarUrlController.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(_successSnackBar());
        // initialize
        _nameController.clear();
        _descriptionController.clear();
        rating = 0;
        _avatarUrlController.clear();
      },
    );
  }
}
