import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:linnefromice/components/wrapper_common_background.dart';
import 'package:linnefromice/components/wrapper_fab_circle_menu.dart';
import 'package:linnefromice/models/account.dart';
import 'package:linnefromice/services/authentication_service.dart';

class SettingsPage extends StatelessWidget {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  Widget _buildMenu({final Icon icon, final String label}) => Card(
    color: Colors.transparent,
    child: ListTile(
      leading: icon,
      title: Text(label, style: TextStyle(color: Colors.white))
    ),
  );

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
              color: Colors.transparent,
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
                    margin: EdgeInsets.symmetric(vertical: 2.5),
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      account.name,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.all(1.0),
                  child: _buildMenu(icon: null, label: "About US")
                ),
                Container(
                  margin: EdgeInsets.all(1.0),
                  child: _buildMenu(icon: null, label: "Privacy Policy")
                ),
                Container(
                  margin: EdgeInsets.all(1.0),
                  child: _buildMenu(icon: null, label: "Terms & Conditions")
                ),
                Container(
                  margin: EdgeInsets.all(1.0),
                  child: _buildMenu(icon: null, label: "Sign out")
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) => WrapperFabCircularMenu(fabKey: fabKey)
      ),
    );
  }
}
