import 'package:flutter/material.dart';
import 'package:linnefromice/components/wrapper_common_background.dart';
import 'package:linnefromice/screens/home_page.dart';

class LoginPage extends StatelessWidget {
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

  Widget _buildDescriptionTwo() => Text(
    "You can reflect",
    style: TextStyle(
      color: Colors.white,
      fontSize: 18,
    ),
  );

  @override
  Widget build(BuildContext context) {
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
                  primary: Colors.grey,
                  onPrimary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomePage())
                  );
                }, // TODO: show dialog
              ),
            )
          ],
        )
      ),
    );
  }

}