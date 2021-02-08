// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Account _$_$_AccountFromJson(Map<String, dynamic> json) {
  return _$_Account(
    id: json['id'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    rating: (json['rating'] as num)?.toDouble(),
    isFriend: json['isFriend'] as bool,
    avatarUrl: json['avatarUrl'] as String,
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
    version: json['version'] as int,
  );
}

Map<String, dynamic> _$_$_AccountToJson(_$_Account instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'rating': instance.rating,
      'isFriend': instance.isFriend,
      'avatarUrl': instance.avatarUrl,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'version': instance.version,
    };
