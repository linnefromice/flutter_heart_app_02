import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linnefromice/models/user.dart';

class UserService {
  final _instance = FirebaseFirestore.instance;

  Future<List<User>> findUsers() async {
    QuerySnapshot querySnapshot = await _instance.collection("users").get();
    return querySnapshot.docs.map((DocumentSnapshot document) => User(
      name: document.data()["name"],
      rating: document.data()["rating"],
      isFriend: document.data()["isFriend"],
      avatarUrl: document.data()["avatarUrl"],
    ));
  }
}
