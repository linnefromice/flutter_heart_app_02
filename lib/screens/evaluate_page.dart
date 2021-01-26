import 'package:flutter/material.dart';
import 'package:linnefromice/components/wrapper_common_background.dart';
import 'package:linnefromice/models/user.dart';

class EvaluatePage extends StatelessWidget {
  EvaluatePage({
    Key key,
    @required this.user
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WrapperCommonBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("id: ${user.id}"),
            Text("name: ${user.name}"),
            Text("rating: ${user.rating.toString()}"),
            Text("avatarUrl: ${user.avatarUrl}"),
            Text("isFriend: ${user.isFriend.toString()}"),
          ],
        ),
      ),
    );
  }
}