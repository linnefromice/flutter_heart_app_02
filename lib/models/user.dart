import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  const factory User({
    String name,
    int rating,
    bool isFriend,
    String avatarUrl
  }) = _User;
}
