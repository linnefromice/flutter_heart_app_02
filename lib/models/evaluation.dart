import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'evaluation.freezed.dart';
part 'evaluation.g.dart';

@freezed
abstract class Evaluation with _$Evaluation {
  const factory Evaluation({
    String id,
    String userId,
    double rating,
    String createdDate,
    DateTime createdAt,
  }) = _Evaluation;

  factory Evaluation.fromJson(Map<String, dynamic> json) => _$EvaluationFromJson(json);
}