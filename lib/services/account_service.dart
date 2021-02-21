import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/account.dart';

class AccountService {
  final _instance = FirebaseFirestore.instance;
  final _collectionName = "accounts";
  final _defaultSortKey = "updatedAt";

  Account _generateModelFromQueryDocumentSnapshot(
    QueryDocumentSnapshot snapshot
  ) => Account(
    id: snapshot.data()["id"], // snapshot.id,
    name: snapshot.data()["name"],
    description: snapshot.data()["description"],
    rating: snapshot.data()["rating"],
    isFriend: snapshot.data()["isFriend"],
    avatarUrl: snapshot.data()["avatarUrl"],
    createdAt: snapshot.data()["createdAt"],
    updatedAt: snapshot.data()["updatedAt"],
    version: snapshot.data()["version"],
  );

  Stream<List<Account>> streamAccounts() {
    return _instance.collection(_collectionName).orderBy(_defaultSortKey).snapshots().map(
      (querySnapshot) => querySnapshot.docs.map(
        (queryDocumentSnapshot) => _generateModelFromQueryDocumentSnapshot(queryDocumentSnapshot)
      ).toList()
    );
  }

  Account _generateModelFromDocumentSnapshot(
    DocumentSnapshot snapshot
  ) => Account(
    id: snapshot.data()["id"], // snapshot.id,
    name: snapshot.data()["name"],
    description: snapshot.data()["description"],
    rating: snapshot.data()["rating"],
    isFriend: snapshot.data()["isFriend"],
    avatarUrl: snapshot.data()["avatarUrl"],
    createdAt: snapshot.data()["createdAt"],
    updatedAt: snapshot.data()["updatedAt"],
    version: snapshot.data()["version"],
  );

  Future<List<Account>> findAccounts() async {
    QuerySnapshot querySnapshot = await _instance.collection(_collectionName).orderBy(_defaultSortKey).get();
    return querySnapshot.docs.map(
      (documentSnapshot) => _generateModelFromDocumentSnapshot(documentSnapshot)
    ).toList();
  }

  Future<Account> findAccount(final String id) async {
    // TODO: カラム名変更 or ドキュメントパス変更 (whereを使いたくない)
    QuerySnapshot querySnapshot = await _instance.collection(_collectionName).where("id", isEqualTo: id).get();
    return _generateModelFromDocumentSnapshot(querySnapshot.docs.first);
  }

  Future<void> createAccount({
    final String id,
    final String name,
    final String description,
    final double rating,
    final bool isFriend,
    final String avatarUrl
  }) async {
    final DateTime now = DateTime.now();
    _instance.collection(_collectionName).add(
      Account(
        id: id,
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

  Future<void> deleteAccount(final String id) async {
    _instance.collection(_collectionName).doc(id).delete();
  }

  Future<void> updateRating(
    final String id,
    final int currentVersion,
    final double newRating
  ) async {
    final DateTime now = DateTime.now();
    _instance.collection(_collectionName).doc(id).update({
      "rating": newRating,
      "updatedAt": now.toIso8601String(),
      "version": currentVersion + 1
    });
  }
}
