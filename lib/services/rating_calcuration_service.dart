import 'package:flutter/material.dart';
import 'package:linnefromice/models/evaluation.dart';
import 'package:linnefromice/models/user.dart';
import 'package:linnefromice/services/user_service.dart';
import 'package:linnefromice/services/evaluation_service.dart';

class RatingInformation {
  RatingInformation({
    @required this.userId,
    @required this.name,
    @required this.rating,
    @required this.newRating
  });

  final String userId;
  final String name;
  final double rating;
  final double newRating;
}

class RatingCalculationService {
  final userService = UserService();
  final evaluationService = EvaluationService();

  Future<List<RatingInformation>> getNewRatingInformationList() async {
    final List<User> users = await userService.findUsers();
    final List<Evaluation> evaluations = await evaluationService.findEvaluations();

    final List<RatingInformation> results = users.map((user) {
      final List<Evaluation> selectedEvaluations = evaluations.where((el) => el.userId == user.id).toList();
      if (selectedEvaluations.isNotEmpty) {
        final List<double> values = selectedEvaluations.map((element) => element.rating).toList();
        return RatingInformation(
            userId: user.id,
            name: user.name,
            rating: user.rating,
            newRating: values.reduce((curr, next) => curr + next) / values.length // calculate average of evaluations
        );
      }
    }).toList();
    results.removeWhere((element) => element == null); // remove user's element of no evaluation
    return results;
  }
}