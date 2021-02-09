import 'package:firebase_auth/firebase_auth.dart';
import 'package:linnefromice/models/account.dart';
import 'package:linnefromice/services/account_service.dart';

final FirebaseAuth _firebaseAuthInstance = FirebaseAuth.instance;


class AuthenticationService {
  final accountService = AccountService();
  static Account currentAccount;

  User get currentUser => _firebaseAuthInstance.currentUser;

  Future<String> authenticate({final String email, final String domain, final String password}) async {
    try {
      UserCredential credential = await _firebaseAuthInstance
        .signInWithEmailAndPassword(
          email: email + "@" + domain,
          password: password
        );
      currentAccount = await accountService.findAccount(credential.user.uid);
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