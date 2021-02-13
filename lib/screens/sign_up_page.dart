import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:linnefromice/components/wrapper_common_background.dart';

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

  ElevatedButton _buildButtonRelatedAuthentication({final String label, final IconData iconData, final Function onPressed}) {
    return ElevatedButton.icon(
      icon: Icon(
        iconData,
        size: 48,
        color: Colors.white,
      ),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        onPrimary: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
      ),
      onPressed: onPressed,
    );
  }

  ElevatedButton _buildBackButton(BuildContext context) {
    return _buildButtonRelatedAuthentication(
        iconData: Icons.arrow_back,
        label: "Back",
        onPressed: () => Navigator.of(context).pop()
    );
  }

  ElevatedButton _buildSubmitButton(BuildContext context, TextEditingController localPartController, ValueNotifier<String> selectedDomain, TextEditingController passwordController) {
    return _buildButtonRelatedAuthentication(
        iconData: Icons.person_add,
        label: "SIGN UP",
        onPressed: () => {}
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

  TextField _buildEmailField(TextEditingController localPartController) {
    return TextField(
      controller: localPartController,
      keyboardType: TextInputType.emailAddress,
      obscureText: false,
      style: TextStyle(
          fontSize: 18.0,
          color: Colors.white
      ),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          prefixIcon: Icon(Icons.account_circle, color: Colors.white),
          hintText: "Email",
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(32.0)
          )
      ),
    );
  }

  Theme _buildEmailDomainSelector(ValueNotifier<String> selectedDomain) {
    return Theme(
      data: ThemeData(
          canvasColor: Colors.grey
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedDomain.value,
          onChanged: (value) => selectedDomain.value = value,
          style: TextStyle(color: Colors.white),
          items: domainList.map((value) => DropdownMenuItem(
            value: value,
            child: Text(value),
          )) .toList(),
        ),
      ),
    );
  }

  TextField _buildPasswordField(TextEditingController passwordController, ValueNotifier<bool> _isObscureText) {
    return TextField(
      controller: passwordController,
      keyboardType: TextInputType.text,
      obscureText: _isObscureText.value,
      style: TextStyle(
          fontSize: 18.0,
          color: Colors.white
      ),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          prefixIcon: Icon(Icons.lock, color: Colors.white),
          hintText: "Password",
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(32.0),
          )
      ),
    );
  }

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
                    child: _buildEmailField(_localPartController),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text("@", style: TextStyle(color: Colors.white))
                  ),
                  _buildEmailDomainSelector(_selectedDomain)
                ]
              ),
            ),
            Container( // Input Password
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: _buildPasswordField(_passwordController, _isObscureText),
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
                  _buildSubmitButton(context, _localPartController, _selectedDomain, _passwordController),
                ],
              ),
            ),
          ]
        )
      ),
    );
  }
}