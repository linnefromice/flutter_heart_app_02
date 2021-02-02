import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linnefromice/models/user.dart';

class UserService {
  final _instance = FirebaseFirestore.instance;
  final _collectionName = "users";
  final _defaultSortKey = "updatedAt";

  User _generateUserFromQueryDocumentSnapshot(QueryDocumentSnapshot snapshot) => User(
    id: snapshot.id,
    name: snapshot.data()["name"],
    description: snapshot.data()["description"],
    rating: snapshot.data()["rating"],
    isFriend: snapshot.data()["isFriend"],
    avatarUrl: snapshot.data()["avatarUrl"],
  );

  Stream<List<User>> streamUsers() {
    return _instance.collection(_collectionName).orderBy(_defaultSortKey).snapshots().map(
      (QuerySnapshot querySnapshot) => querySnapshot.docs.map(
        (QueryDocumentSnapshot queryDocumentSnapshot) => _generateUserFromQueryDocumentSnapshot(queryDocumentSnapshot)
      ).toList()
    );
  }

  User _generateUserFromDocumentSnapshot(DocumentSnapshot snapshot) => User(
    id: snapshot.id,
    name: snapshot.data()["name"],
    description: snapshot.data()["description"],
    rating: snapshot.data()["rating"],
    isFriend: snapshot.data()["isFriend"],
    avatarUrl: snapshot.data()["avatarUrl"],
  );

  Future<List<User>> findUsers() async {
    QuerySnapshot querySnapshot = await _instance.collection(_collectionName).orderBy(_defaultSortKey).get();
    return querySnapshot.docs.map(
      (DocumentSnapshot documentSnapshot) => _generateUserFromDocumentSnapshot(documentSnapshot)
    ).toList();
  }
  
  Future<void> createUser({ final String name, final String description, final double rating, final bool isFriend, final String avatarUrl }) async {
    final DateTime now = DateTime.now();
    _instance.collection(_collectionName).add(
      User(
        name: name,
        description: description,
        rating: rating,
        isFriend: isFriend,
        avatarUrl: avatarUrl,
        createdAt: now.toIso8601String(),
        updatedAt: now.toIso8601String(),
        version: 1
      ).toJson()
    );
  }

  Future<void> deleteUser(final String id) async {
    _instance.collection(_collectionName).doc(id).delete();
  }

  Future<void> updateRating(final String id, final int currentVersion, final double newRating) {
    final DateTime now = DateTime.now();
    _instance.collection(_collectionName).doc(id).update({
      "rating": newRating,
      "updatedAt": now.toIso8601String(),
      "version": currentVersion + 1
    });
  }
}
