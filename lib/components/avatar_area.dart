import 'package:flutter/material.dart';

class AvatarArea extends StatelessWidget {
  AvatarArea({
    Key key,
    @required this.diameter,
    this.child,
    this.image
  }) : super(key: key);
  final double diameter;
  final Widget child;
  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: diameter,
      width: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.red[100],
            Colors.deepOrange[100],
          ],
        )
      ),
      child: FractionallySizedBox(
        alignment: Alignment.topCenter,
        widthFactor: 0.6,
        child: CircleAvatar(
          maxRadius: 30,
          child: child,
          backgroundImage: image
        )
      ),
    );
  }
}