// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evaluation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Evaluation _$_$_EvaluationFromJson(Map<String, dynamic> json) {
  return _$_Evaluation(
    id: json['id'] as String,
    userId: json['userId'] as String,
    rating: (json['rating'] as num)?.toDouble(),
    createdDate: json['createdDate'] as String,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
  );
}

Map<String, dynamic> _$_$_EvaluationToJson(_$_Evaluation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'rating': instance.rating,
      'createdDate': instance.createdDate,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
