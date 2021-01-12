import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:linnefromice/screens/home_page.dart';
import 'package:linnefromice/screens/users_page.dart';

class WrapperFabCircularMenu extends StatelessWidget {
  WrapperFabCircularMenu({
    Key key,
    this.fabKey,
  }) : super(key: key);

  final GlobalKey<FabCircularMenuState> fabKey;

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
        RawMaterialButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => HomePage())
          ),
          shape: CircleBorder(),
          padding: EdgeInsets.all(24.0),
          child: Icon(Icons.home, color: Colors.white),
        ),
        RawMaterialButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => UsersPage())
          ),
          shape: CircleBorder(),
          padding: EdgeInsets.all(24.0),
          child: Icon(Icons.supervisor_account, color: Colors.white),
        ),
        RawMaterialButton(
          onPressed: () => print("Unimplemented"),
          shape: CircleBorder(),
          padding: EdgeInsets.all(24.0),
          child: Icon(Icons.save, color: Colors.white),
        ),
        RawMaterialButton(
          onPressed: () => print("Unimplemented"),
          shape: CircleBorder(),
          padding: EdgeInsets.all(24.0),
          child: Icon(Icons.settings, color: Colors.white),
        ),
        RawMaterialButton(
          onPressed: () {
            fabKey.currentState.close();
          },
          shape: CircleBorder(),
          padding: EdgeInsets.all(24.0),
          child: Icon(Icons.close, color: Colors.white),
        )
      ],
    );
  }
}
