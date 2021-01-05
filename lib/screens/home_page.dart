import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => FabCircularMenu(
          key: fabKey,
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            RawMaterialButton(
              onPressed: () {
                print("You pressed 1");
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Icon(Icons.looks_one, color: Colors.white),
            ),
            RawMaterialButton(
              onPressed: () {
                print("You pressed 2");
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Icon(Icons.looks_two, color: Colors.white),
            ),
            RawMaterialButton(
              onPressed: () {
                print("You pressed 3");
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Icon(Icons.looks_3, color: Colors.white),
            ),
            RawMaterialButton(
              onPressed: () {
                print("You pressed 4. This one closes the menu on tap");
                fabKey.currentState.close();
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Icon(Icons.looks_4, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}