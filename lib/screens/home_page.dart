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
            Positioned(
              top: MediaQuery.of(context).size.height * 0.25,
              left: 0,
              right: 0,
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
                  widthFactor: 0.5,
                  child: CircleAvatar(
                    maxRadius: 30,
                    child: Text("Avatar", style: TextStyle(color: Colors.red)),
                    backgroundColor: Colors.white,
                  )
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.5,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonTheme(
                    minWidth: 50,
                    height: 50,
                    child: RaisedButton(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      color: Colors.transparent,
                      shape: CircleBorder(),
                      onPressed: () {}
                    ),
                  ),
                  SizedBox(width: 200),
                  ButtonTheme(
                    minWidth: 50,
                    height: 50,
                    child: RaisedButton(
                      child: Icon(Icons.arrow_forward, color: Colors.white,),
                      color: Colors.transparent,
                      shape: CircleBorder(),
                      onPressed: () {}
                    ),
                  )
                ],
              )
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.6,
              left: 0,
              right: 0,
              child: Center(
                child: Text("Avatar", style: TextStyle(color: Colors.red)),
              )
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.65,
              left: 0,
              right: 0,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite, size: 50, color: Colors.pink.withOpacity(0.5)),
                    Icon(Icons.favorite, size: 50, color: Colors.pink.withOpacity(0.5)),
                    Icon(Icons.favorite, size: 50, color: Colors.pink.withOpacity(0.5)),
                    Icon(Icons.favorite, size: 50, color: Colors.pink.withOpacity(0.5)),
                    Icon(Icons.favorite, size: 50, color: Colors.pink.withOpacity(0.5)),
                  ],
                )
              )
            )
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