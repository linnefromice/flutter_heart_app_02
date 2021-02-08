import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  final _instance = FirebaseAuth.instance;

  Future<bool> _authenticate({final String email, final String domain, final String password}) async {
    try {
      await _instance
          .signInWithEmailAndPassword(
          email: email + "@" + domain,
          password: password
      );
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }
}