import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'evaluation.freezed.dart';
part 'evaluation.g.dart';

@freezed
abstract class Evaluation with _$Evaluation {
  const factory Evaluation({
    String id,
    String fromUserId,
    String toUserId,
    double rating,
    String createdDate,
    String createdAt, // temp (instead of DateTime)
    String updatedAt, // temp (instead of DateTime)
    int version
  }) = _Evaluation;

  factory Evaluation.fromJson(Map<String, dynamic> json)
    => _$EvaluationFromJson(json);
}
