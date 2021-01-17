import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linnefromice/models/user.dart';

class UserService {
  final _instance = FirebaseFirestore.instance;
  final _collectionName = "users";

  User _generateUserFromQueryDocumentSnapshot(QueryDocumentSnapshot snapshot) => User(
    name: snapshot.data()["name"],
    rating: snapshot.data()["rating"],
    isFriend: snapshot.data()["isFriend"],
    avatarUrl: snapshot.data()["avatarUrl"],
  );

  Stream<List<User>> streamUsers() {
    return _instance.collection(_collectionName).snapshots().map(
      (QuerySnapshot querySnapshot) => querySnapshot.docs.map(
        (QueryDocumentSnapshot queryDocumentSnapshot) => _generateUserFromQueryDocumentSnapshot(queryDocumentSnapshot)
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
    QuerySnapshot querySnapshot = await _instance.collection(_collectionName).get();
    return querySnapshot.docs.map(
      (DocumentSnapshot documentSnapshot) => _generateUserFromDocumentSnapshot(documentSnapshot)
    ).toList();
  }
}
