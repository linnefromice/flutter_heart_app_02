// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$_$_UserFromJson(Map<String, dynamic> json) {
  return _$_User(
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

Map<String, dynamic> _$_$_UserToJson(_$_User instance) => <String, dynamic>{
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
