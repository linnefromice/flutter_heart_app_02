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

  AvatarArea _buildAvatarArea({final double diameter}) {
    return AvatarArea(
      diameter: diameter,
      image: !(user.avatarUrl == null || user.avatarUrl == "") ? NetworkImage(user.avatarUrl) : null,
      child: user.avatarUrl == null || user.avatarUrl == "" ? Text("NO IMAGE", style: TextStyle(color: Colors.black)) : null,
    );
  }

  Text _buildNameArea() => Text(
    user.name,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 30.0,
      color: Colors.white
    ),
  );

  Row _buildRatingArea() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(Icons.favorite, size: 50, color: user.rating >= 1 ? Colors.pink.withOpacity(0.5) : Colors.white),
      Icon(Icons.favorite, size: 50, color: user.rating >= 2 ? Colors.pink.withOpacity(0.5) : Colors.white),
      Icon(Icons.favorite, size: 50, color: user.rating >= 3 ? Colors.pink.withOpacity(0.5) : Colors.white),
      Icon(Icons.favorite, size: 50, color: user.rating >= 4 ? Colors.pink.withOpacity(0.5) : Colors.white),
      Icon(Icons.favorite, size: 50, color: user.rating >= 5 ? Colors.pink.withOpacity(0.5) : Colors.white),
    ],
  );

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
              child: _buildAvatarArea(
                diameter: MediaQuery.of(context).size.width * 0.8
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.65,
              left: 0,
              right: 0,
              child: _buildNameArea(),
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
              child: _buildRatingArea(),
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