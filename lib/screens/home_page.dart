import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:linnefromice/components/wrapper_common_background.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WrapperCommonBackground(
        child: Center(
          child: Text("Home"),
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) => FabCircularMenu(
          key: fabKey,
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            RawMaterialButton(
              onPressed: () => print("You pressed 1"),
              shape: CircleBorder(),
              padding: EdgeInsets.all(24.0),
              child: Icon(Icons.home, color: Colors.white),
            ),
            RawMaterialButton(
              onPressed: () => print("You pressed 2"),
              shape: CircleBorder(),
              padding: EdgeInsets.all(24.0),
              child: Icon(Icons.supervisor_account, color: Colors.white),
            ),
            RawMaterialButton(
              onPressed: () => print("You pressed 3"),
              shape: CircleBorder(),
              padding: EdgeInsets.all(24.0),
              child: Icon(Icons.save, color: Colors.white),
            ),
            RawMaterialButton(
              onPressed: () => print("You pressed 4. This one closes the menu on tap"),
              shape: CircleBorder(),
              padding: EdgeInsets.all(24.0),
              child: Icon(Icons.settings, color: Colors.white),
            ),
            RawMaterialButton(
              onPressed: () {
                print("You pressed 5. This one closes the menu on tap");
                fabKey.currentState.close();
              },
              shape: CircleBorder(),
              padding: EdgeInsets.all(24.0),
              child: Icon(Icons.close, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}