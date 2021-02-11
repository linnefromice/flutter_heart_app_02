import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:linnefromice/screens/evaluations_page.dart';
import 'package:linnefromice/screens/home_page.dart';
import 'package:linnefromice/screens/accounts_page.dart';
import 'package:linnefromice/screens/settings_page.dart';

class WrapperFabCircularMenu extends StatelessWidget {
  WrapperFabCircularMenu({
    Key key,
    this.fabKey,
  }) : super(key: key);

  final GlobalKey<FabCircularMenuState> fabKey;

  RawMaterialButton _buildRawMaterialButton({final Icon icon, final Function onPressed}) {
    return RawMaterialButton(
      onPressed: onPressed,
      shape: CircleBorder(),
      padding: EdgeInsets.all(24.0),
      child: icon
    );
  }

  @override
  Widget build(BuildContext context) {
    return FabCircularMenu(
      key: fabKey,
      alignment: Alignment.bottomCenter,
      ringColor: Colors.red.withOpacity(0.5),
      fabColor: Colors.red.withOpacity(0.5),
      fabOpenIcon: Icon(Icons.menu, color: Colors.white),
      fabCloseIcon: Icon(Icons.close, color: Colors.white),
      children: <Widget>[
        _buildRawMaterialButton(
          icon: Icon(Icons.home, color: Colors.white),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => HomePage())
          ),
        ),
        _buildRawMaterialButton(
          icon: Icon(Icons.supervisor_account, color: Colors.white),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AccountsPage()),
          ),
        ),
        _buildRawMaterialButton(
          icon: Icon(Icons.save, color: Colors.white),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EvaluationsPage()),
          ),
        ),
        _buildRawMaterialButton(
          icon: Icon(Icons.settings, color: Colors.white),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => SettingsPage()),
          ),
        ),
        _buildRawMaterialButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () => fabKey.currentState.close()
        ),
      ],
    );
  }
}
