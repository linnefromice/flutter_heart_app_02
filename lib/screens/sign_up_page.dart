import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:linnefromice/components/commons_related_authentication.dart';
import 'package:linnefromice/components/wrapper_common_background.dart';
import 'package:linnefromice/screens/home_page.dart';
import 'package:linnefromice/services/authentication_service.dart';

final List<String> domainList = [
  "gmail.com",
  "yahoo.co.jp",
  "ezweb.ne.jp",
  "au.com",
  "docomo.ne.jp",
  "i.softbank.jp",
  "softbank.ne.jp"
];

class SignUpPage extends HookWidget {
  final authService = AuthenticationService();

  Widget _buildErrorDialog(final BuildContext context, final String title) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(color: Colors.red),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  void _signUp(
      final BuildContext context,
      final String localPart,
      final String domain,
      final String password,
      final String name,
      final String description,
      final String avatarUrl
    ) async {
    final String errorMessage = await authService.signUp(
      email: localPart + "@" + domain,
      password: password,
      name: name,
      description: description,
      avatarUrl: avatarUrl
    );
    if (errorMessage == null) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext buildContext) {
            return _buildErrorDialog(
              context,
              errorMessage
            );
          }
      );
    }
  }

  ElevatedButton _buildBackButton(BuildContext context) {
    return buildButtonRelatedAuthentication(
        iconData: Icons.arrow_back,
        label: "Back",
        onPressed: () => Navigator.of(context).pop()
    );
  }

  ElevatedButton _buildSubmitButton(
      BuildContext context,
      TextEditingController localPartController,
      ValueNotifier<String> selectedDomain,
      TextEditingController passwordController,
      TextEditingController nameController,
      TextEditingController descriptionController,
      TextEditingController avatarUrlController
    ) {
    return buildButtonRelatedAuthentication(
      iconData: Icons.person_add,
      label: "SIGN UP",
      onPressed: () => _signUp(
        context,
        localPartController.text,
        selectedDomain.value,
        passwordController.text,
        nameController.text,
        descriptionController.text,
        avatarUrlController.text
      )
    );
  }

  Widget _buildTitle() => Text(
    "Create Account",
    style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold
    ),
  );

  Widget _buildDescriptionLine(final String description) => Text(
    description,
    style: TextStyle(
      color: Colors.white,
      fontSize: 18,
    ),
  );

  TextField _buildTextField(final TextEditingController _controller, final String label) {
    return TextField(
      controller: _controller,
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        )
      ),
    );
  }

  Row _buildAvatarUrlField(TextEditingController _avatarUrlController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: TextField(
            controller: _avatarUrlController,
            style: TextStyle(color: Colors.white),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                hintText: "AvatarUrl",
                hintStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                )
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

  @override
  Widget build(BuildContext context) {
    // For authentication
    final _localPartController = useTextEditingController();
    final _passwordController = useTextEditingController();
    final _isObscureText = useState(true);
    final _selectedDomain = useState(domainList.first);
    // Fpr Account
    final _nameController = useTextEditingController();
    final _descriptionController = useTextEditingController();
    final _avatarUrlController = useTextEditingController();


    return Scaffold(
      body: WrapperCommonBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.0),
              child: _buildTitle(),
            ),
            _buildDescriptionLine("Please enter your account information."),
            Container( // Input Email
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: buildEmailField(_localPartController),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text("@", style: TextStyle(color: Colors.white))
                  ),
                  buildEmailDomainSelector(_selectedDomain)
                ]
              ),
            ),
            Container( // Input Password
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: buildPasswordField(_passwordController, _isObscureText),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Show password",
                    style: TextStyle(color: Colors.white),
                  ),
                  Theme(
                    data: ThemeData(
                      primarySwatch: Colors.grey,
                      unselectedWidgetColor: Colors.white
                    ),
                    child: Checkbox(
                      value: _isObscureText.value,
                      onChanged: (value) => _isObscureText.value = value,
                    ),
                  )
                ],
              ),
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
              child: _buildAvatarUrlField(_avatarUrlController),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBackButton(context),
                  _buildSubmitButton(
                    context,
                    _localPartController,
                    _selectedDomain,
                    _passwordController,
                    _nameController,
                    _descriptionController,
                    _avatarUrlController
                  ),
                ],
              ),
            ),
          ]
        )
      ),
    );
  }
}