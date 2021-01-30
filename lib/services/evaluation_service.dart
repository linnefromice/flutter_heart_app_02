import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linnefromice/models/evaluation.dart';

class EvaluationService {
  final _instance = FirebaseFirestore.instance;
  final _collectionName = "evaluation";

  Evaluation _generateModelFromQueryDocumentSnapshot(QueryDocumentSnapshot snapshot) => Evaluation(
    id: snapshot.id,
    userId: snapshot.data()["userId"],
    rating: snapshot.data()["rating"],
    createdDate: snapshot.data()["createdDate"],
    createdAt: snapshot.data()["createdAt"],
  );

  Stream<List<Evaluation>> streamEvaluation() {
    return _instance.collection(_collectionName).snapshots().map(
      (QuerySnapshot querySnapshot) => querySnapshot.docs.map(
        (QueryDocumentSnapshot queryDocumentSnapshot) => _generateModelFromQueryDocumentSnapshot(queryDocumentSnapshot)
      ).toList()
    );
  }

  Evaluation _generateModelFromDocumentSnapshot(DocumentSnapshot snapshot) => Evaluation(
    id: snapshot.id,
    userId: snapshot.data()["userId"],
    rating: snapshot.data()["rating"],
    createdDate: snapshot.data()["createdDate"],
    createdAt: snapshot.data()["createdAt"],
  );

  Future<List<Evaluation>> findEvaluations() async {
    QuerySnapshot querySnapshot = await _instance.collection(_collectionName).get();
    return querySnapshot.docs.map(
      (DocumentSnapshot documentSnapshot) => _generateModelFromDocumentSnapshot(documentSnapshot)
    ).toList();
  }
  
  Future<void> createEvaluation({ final String userId, final double rating}) async {
    final DateTime now = DateTime.now();
    final String nowDate = now.year.toString().padLeft(4,"0") + now.month.toString().padLeft(2,"0") + now.day.toString().padLeft(2,"0");
    _instance.collection(_collectionName).add(
      Evaluation(
        userId: userId,
        rating: rating,
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
}
