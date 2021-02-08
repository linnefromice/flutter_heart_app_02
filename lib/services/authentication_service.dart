import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final _instance = FirebaseAuth.instance;

  Future<String> authenticate({final String email, final String domain, final String password}) async {
    try {
      await _instance
        .signInWithEmailAndPassword(
          email: email + "@" + domain,
          password: password
        );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        return "Wrong password provided for that user.";
      }
      return "Internal Server Error";
    }
  }
}