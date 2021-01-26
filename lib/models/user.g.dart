// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$_$_UserFromJson(Map<String, dynamic> json) {
  return _$_User(
    id: json['id'] as String,
    name: json['name'] as String,
    rating: (json['rating'] as num)?.toDouble(),
    isFriend: json['isFriend'] as bool,
    avatarUrl: json['avatarUrl'] as String,
  );
}

Map<String, dynamic> _$_$_UserToJson(_$_User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rating': instance.rating,
      'isFriend': instance.isFriend,
      'avatarUrl': instance.avatarUrl,
    };
