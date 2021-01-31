import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    String id,
    String name,
    String description,
    double rating,
    bool isFriend,
    String avatarUrl,
    String createdAt, // temp (instead of DateTime)
    String updatedAt, // temp (instead of DateTime)
    int version
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
