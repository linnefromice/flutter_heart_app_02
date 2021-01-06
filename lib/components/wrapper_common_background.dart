import 'package:flutter/material.dart';

class WrapperCommonBackground extends StatelessWidget {
  WrapperCommonBackground({
    Key key,
    this.child
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.red[200],
              Colors.orange[100],
              Colors.deepOrange[200]
            ],
          )
      ),
      child: child,
    );
  }
}