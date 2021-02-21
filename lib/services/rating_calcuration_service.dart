import 'package:flutter/material.dart';

import '../models/account.dart';
import '../models/evaluation.dart';
import 'account_service.dart';
import 'evaluation_service.dart';

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
  final accountService = AccountService();
  final evaluationService = EvaluationService();

  Future<List<RatingInformation>> getNewRatingInformationList() async {
    final List<Account> accounts = await accountService.findAccounts();
    final List<Evaluation> evaluations = await evaluationService.findEvaluations();

    final List<RatingInformation> results = accounts.map((account) {
      final List<Evaluation> selectedEvaluations = evaluations.where((el) => el.toUserId == account.id).toList();
      if (selectedEvaluations.isNotEmpty) {
        final List<double> values = selectedEvaluations.map((element) => element.rating).toList();
        return RatingInformation(
          userId: account.id,
          name: account.name,
          rating: account.rating,
          newRating: values.reduce((curr, next) => curr + next) / values.length // calculate average of evaluations
        );
      }
    }).toList();
    // remove user's element of no evaluation
    results.removeWhere((element) => element == null);
    return results;
  }
}
