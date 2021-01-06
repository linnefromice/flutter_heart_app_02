import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:linnefromice/components/wrapper_common_background.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WrapperCommonBackground(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: MediaQuery.of(context).size.width * 0.7,
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.red[100],
                      Colors.deepOrange[100],
                    ],
                  ),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.topCenter,
                  widthFactor: 0.6,
                  child: CircleAvatar(
                    maxRadius: 30,
                    child: Text("Avatar", style: TextStyle(color: Colors.red)),
                    backgroundColor: Colors.white,
                  )
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.70,
              left: 0,
              right: 0,
              child: Center(
                child: Text("Avatar", style: TextStyle(color: Colors.red)),
              )
            ),
          ],
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) => _FabCircularMenu(fabKey: fabKey)
      ),
    );
  }
}

class _FabCircularMenu extends StatelessWidget {
  _FabCircularMenu({
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
    );
  }

}