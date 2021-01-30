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
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
    version: json['version'] as int,
  );
}

Map<String, dynamic> _$_$_EvaluationToJson(_$_Evaluation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'rating': instance.rating,
      'createdDate': instance.createdDate,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'version': instance.version,
    };
