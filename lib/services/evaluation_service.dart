import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/evaluation.dart';

class EvaluationService {
  final _instance = FirebaseFirestore.instance;
  final _collectionName = "evaluations";
  final _defaultSortKey = "updatedAt";

  Evaluation _generateModelFromQueryDocumentSnapshot(
    QueryDocumentSnapshot snapshot
  ) => Evaluation(
    id: snapshot.id,
    fromUserId: snapshot.data()["fromUserId"],
    toUserId: snapshot.data()["toUserId"],
    rating: snapshot.data()["rating"],
    createdDate: snapshot.data()["createdDate"],
    createdAt: snapshot.data()["createdAt"],
    updatedAt: snapshot.data()["updatedAt"],
    version: snapshot.data()["version"],
  );

  Stream<List<Evaluation>> streamEvaluation() {
    return _instance
        .collection(_collectionName)
        .orderBy(_defaultSortKey, descending: true)
        .snapshots().map(
          (querySnapshot) => querySnapshot.docs.map(
            _generateModelFromQueryDocumentSnapshot
          ).toList()
    );
  }

  Evaluation _generateModelFromDocumentSnapshot(
    DocumentSnapshot snapshot
  ) => Evaluation(
    id: snapshot.id,
    fromUserId: snapshot.data()["fromUserId"],
    toUserId: snapshot.data()["toUserId"],
    rating: snapshot.data()["rating"],
    createdDate: snapshot.data()["createdDate"],
    createdAt: snapshot.data()["createdAt"],
    updatedAt: snapshot.data()["updatedAt"],
    version: snapshot.data()["version"],
  );

  Future<List<Evaluation>> findEvaluations() async {
    QuerySnapshot querySnapshot = await _instance
        .collection(_collectionName)
        .orderBy(_defaultSortKey, descending: true)
        .get();
    return querySnapshot.docs.map(
      _generateModelFromDocumentSnapshot
    ).toList();
  }

  Future<List<Evaluation>> findEvaluationsOfSelectedUser(
    final String userId
  ) async {
    QuerySnapshot querySnapshot = await _instance
        .collection(_collectionName)
        .orderBy(_defaultSortKey, descending: true)
        .where("userId", isEqualTo: userId)
        .get();
    return querySnapshot.docs.map(
      _generateModelFromDocumentSnapshot
    ).toList();
  }

  Future<List<Evaluation>> findEvaluationsOfSelectedPeriod(
    final String fromCreatedDate,
    final String toCreatedDate
  ) async {
    QuerySnapshot querySnapshot = await _instance
        .collection(_collectionName)
        .orderBy(_defaultSortKey, descending: true)
        .where("createdAt", isGreaterThanOrEqualTo: fromCreatedDate, isLessThanOrEqualTo: toCreatedDate)
        .get();
    return querySnapshot.docs.map(
        _generateModelFromDocumentSnapshot
    ).toList();
  }

  Future<void> createEvaluation({
    final String fromUserId,
    final String toUserId,
    final double rating
  }) async {
    final _roundedRating = double.parse(rating.toStringAsFixed(2)); // format to X.XX
    final DateTime now = DateTime.now();
    final String nowDate = now.year.toString().padLeft(4,"0") + now.month.toString().padLeft(2,"0") + now.day.toString().padLeft(2,"0");
    _instance.collection(_collectionName).add(
      Evaluation(
        fromUserId: fromUserId,
        toUserId: toUserId,
        rating: _roundedRating,
        createdDate: nowDate,
        createdAt: now.toIso8601String(),
        updatedAt: now.toIso8601String(),
        version: 1
      ).toJson()
    );
  }

  Future<void> deleteEvaluation(final String id) async {
    _instance.collection(_collectionName).doc(id).delete();
  }

  Future<void> deleteEvaluationsSelectedUser(final String userId) async {
    final CollectionReference evaluationsSchema = _instance.collection(_collectionName);
    QuerySnapshot querySnapshot = await evaluationsSchema.where("userId", isEqualTo: userId).get();
    return querySnapshot.docs.forEach((element) {
      evaluationsSchema.doc(element.id).delete();
    });
  }
}
