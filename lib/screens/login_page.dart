import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:linnefromice/components/wrapper_common_background.dart';
import 'package:linnefromice/screens/add_user_page.dart';
import 'package:linnefromice/screens/home_page.dart';

final List<String> domainList = [
  "gmail.com",
  "yahoo.co.jp",
  "ezweb.ne.jp",
  "au.com",
  "docomo.ne.jp",
  "i.softbank.jp",
  "softbank.ne.jp"
];

class LoginPage extends HookWidget {
  Widget _buildTitle() => Text(
    "Rating",
    style: TextStyle(
      color: Colors.white,
      fontSize: 48,
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

  void _authenticate({final BuildContext context, final String email, final String domain, final String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: email + "@" + domain,
          password: password
        );
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(
          context: context,
          builder: (BuildContext buildContext) {
            return _buildErrorDialog(
              context,
              "No user found for that email."
            );
          }
        );
      } else if (e.code == 'wrong-password') {
        showDialog(
          context: context,
          builder: (BuildContext buildContext) {
            return _buildErrorDialog(
              context,
              "Wrong password provided for that user."
            );
          }
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _emailController = useTextEditingController();
    final _passwordController = useTextEditingController();
    final _isObscureText = useState(true);
    final _selectedDomain = useState(domainList.first);

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
            _buildDescriptionLine("You can reflect"),
            _buildDescriptionLine("feelings to actually evaluations..."),
            Container( // Input Email
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: TextField( // TODO: can select domain (ex @gmail.com)
                      controller: _emailController,
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
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text("@", style: TextStyle(color: Colors.white))
                  ),
                  Theme(
                    data: ThemeData(
                      canvasColor: Colors.grey
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedDomain.value,
                        onChanged: (value) => _selectedDomain.value = value,
                        style: TextStyle(color: Colors.white),
                        items: domainList.map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        )) .toList(),
                      ),
                    ),
                  )
                ]
              ),
            ),
            Container( // Input Password
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: _passwordController,
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
              ),
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
              margin: EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton.icon(
                icon: Icon(
                  Icons.login,
                  size: 48,
                  color: Colors.white,
                ),
                label: Text(
                  "LOGIN",
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
                onPressed: () => _authenticate(
                  context: context,
                  email: _emailController.text,
                  domain: _selectedDomain.value,
                  password: _passwordController.text
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton.icon(
                icon: Icon(
                  Icons.build,
                  size: 24,
                  color: Colors.white,
                ),
                label: Text(
                  "DEBUG\nadd user",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  onPrimary: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                ),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddUserPage()
                  )
                )
              ),
            )
          ],
        )
      ),
    );
  }
}