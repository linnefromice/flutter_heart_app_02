import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:linnefromice/screens/users_page.dart';

import 'screens/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heart App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Scaffold(body: Center(child: Text("Occurred Error when initialize Firebase ...")));
          }
          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return UsersPage();
          }
          // Otherwise, show something whilst waiting for initialization to complete
          return Scaffold(body: Center(child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Text("Loading ...")
            ],
          )));
        },
      ),
    );
  }
}
