import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:linnefromice/components/wrapper_common_background.dart';

class UsersPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WrapperCommonBackground(
        child: Center(
          child: Text("Users Page"),
        ),
      ),
    );
  }
}