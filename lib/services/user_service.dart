import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linnefromice/models/user.dart';

class UserService {
  final _instance = FirebaseFirestore.instance;

  User _generateUserFromQueryDocumentSnapshot(QueryDocumentSnapshot queryDocumentSnapshot) => User(
    name: queryDocumentSnapshot.data()["name"],
    rating: queryDocumentSnapshot.data()["rating"],
    isFriend: queryDocumentSnapshot.data()["isFriend"],
    avatarUrl: queryDocumentSnapshot.data()["avatarUrl"],
  );

  Stream<List<User>> streamUsers() {
    return _instance.collection("users").snapshots().map(
      (QuerySnapshot querySnapshot) => querySnapshot.docs.map(
        (QueryDocumentSnapshot snapshot) => _generateUserFromQueryDocumentSnapshot(snapshot)
      ).toList()
    );
  }

  User _generateUserFromDocumentSnapshot(DocumentSnapshot snapshot) => User(
    name: snapshot.data()["name"],
    rating: snapshot.data()["rating"],
    isFriend: snapshot.data()["isFriend"],
    avatarUrl: snapshot.data()["avatarUrl"],
  );

  Future<List<User>> findUsers() async {
    QuerySnapshot querySnapshot = await _instance.collection("users").get();
    return querySnapshot.docs.map((DocumentSnapshot document) => _generateUserFromDocumentSnapshot(document)).toList();
  }
}
