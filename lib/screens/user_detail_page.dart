import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:linnefromice/components/avatar_area.dart';
import 'package:linnefromice/components/wrapper_common_background.dart';
import 'package:linnefromice/components/wrapper_fab_circle_menu.dart';
import 'package:linnefromice/models/user.dart';

class UserDetailPage extends HookWidget {
  UserDetailPage({
    Key key,
    @required this.user
  }) : super(key: key);

  final User user;
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
                image: NetworkImage(user.avatarUrl),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.65,
              left: 0,
              right: 0,
              child: Text(
                user.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 30.0,
                  color: Colors.white
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.70,
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              child: Divider(height: 40, thickness: 2, color: Colors.white),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.75,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.favorite, size: 50, color: user.rating >= 1 ? Colors.pink.withOpacity(0.5) : Colors.white),
                  Icon(Icons.favorite, size: 50, color: user.rating >= 2 ? Colors.pink.withOpacity(0.5) : Colors.white),
                  Icon(Icons.favorite, size: 50, color: user.rating >= 3 ? Colors.pink.withOpacity(0.5) : Colors.white),
                  Icon(Icons.favorite, size: 50, color: user.rating >= 4 ? Colors.pink.withOpacity(0.5) : Colors.white),
                  Icon(Icons.favorite, size: 50, color: user.rating >= 5 ? Colors.pink.withOpacity(0.5) : Colors.white),
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