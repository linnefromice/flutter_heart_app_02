import 'package:flutter/material.dart';
import 'package:linnefromice/components/avatar_area.dart';
import 'package:linnefromice/components/wrapper_common_background.dart';
import 'package:linnefromice/models/account.dart';
import 'package:linnefromice/services/authentication_service.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Account account = AuthenticationService.currentAccount;

    return Scaffold(
      body: WrapperCommonBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Card(
              color: Colors.white.withOpacity(0.80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                    padding: EdgeInsets.all(15.0),
                    child: CircleAvatar(
                      maxRadius: 150,
                      child: account.avatarUrl == null || account.avatarUrl == "" ? Text("NO IMAGE", style: TextStyle(color: Colors.black)) : null,
                      backgroundImage: !(account.avatarUrl == null || account.avatarUrl == "") ? NetworkImage(account.avatarUrl) : null,
                      backgroundColor: Colors.white,
                    )
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                    padding: EdgeInsets.all(15.0),
                    child: Text(account.name)
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            Card(
              color: Colors.white.withOpacity(0.80),
              child: Column(
                children: [
                  ListTile(title: Text("About US")),
                  ListTile(title: Text("Privacy Policy")),
                  ListTile(title: Text("Terms & Conditions")),
                  ListTile(title: Text("Sign out")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}