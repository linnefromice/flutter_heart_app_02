import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:linnefromice/components/avatar_area.dart';
import 'package:linnefromice/components/wrapper_common_background.dart';
import 'package:linnefromice/components/wrapper_fab_circle_menu.dart';

class UserDetailPage extends HookWidget {
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
              child: AvatarArea(
                diameter: MediaQuery.of(context).size.width * 0.8,
                image: NetworkImage("https://static.wikia.nocookie.net/finalfantasy/images/1/11/Zidane_Tribal_character.png/revision/latest/scale-to-width-down/84?cb=20120811142151"),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.65,
              left: 0,
              right: 0,
              child: Text(
                "Zidane Tribal",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 30.0,
                  color: Colors.white
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.75,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.favorite, size: 50, color: Colors.pink.withOpacity(0.5)),
                  Icon(Icons.favorite, size: 50, color: Colors.pink.withOpacity(0.5)),
                  Icon(Icons.favorite, size: 50, color: Colors.pink.withOpacity(0.5)),
                  Icon(Icons.favorite, size: 50, color: Colors.pink.withOpacity(0.5)),
                  Icon(Icons.favorite, size: 50, color: Colors.white),
                ],
            ),
            )
          ],
        )
      ),
      floatingActionButton: Builder(
        builder: (context) => WrapperFabCircularMenu(fabKey: fabKey)
      ),
    );
  }
}