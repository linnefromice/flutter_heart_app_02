import 'package:firebase_auth/firebase_auth.dart';

import '../models/account.dart';
import 'account_service.dart';

final FirebaseAuth _firebaseAuthInstance = FirebaseAuth.instance;

class AuthenticationService {
  final accountService = AccountService();
  static Account currentAccount;

  User get currentUser => _firebaseAuthInstance.currentUser;

  Future<String> authenticate({
    final String email,
    final String password
  }) async {
    try {
      UserCredential credential = await _firebaseAuthInstance
        .signInWithEmailAndPassword(
          email: email,
          password: password
        );
      currentAccount = await accountService.findAccount(credential.user.uid);
      if (currentAccount == null) {
        return "Internal Server Error (Not found related user)";
      }
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

  Future<String> signUp({
    final String email,
    final String password,
    final String name,
    final String description,
    final String avatarUrl
  }) async {
    try {
      UserCredential credential = await _firebaseAuthInstance
        .createUserWithEmailAndPassword(
          email: email,
          password: password
        );

      // Account作成
      await accountService.createAccount(
        id: credential.user.uid,
        name: name,
        description: description,
        rating: 0,
        isFriend: false, // initial status
        avatarUrl: avatarUrl,
      );
      currentAccount = await accountService.findAccount(credential.user.uid);
      if (currentAccount == null) {
        return "Internal Server Error (Not found related user)";
      }
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        return "The account already exists for that email.";
      }
      return "Internal Server Error";
    } on Exception catch (e) {
      print(e);
      return "Internal Server Error";
    }
  }
}
