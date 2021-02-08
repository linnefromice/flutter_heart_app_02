import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'account.freezed.dart';
part 'account.g.dart';

@freezed
abstract class Account with _$Account {
  const factory Account({
    String id,
    String name,
    String description,
    double rating,
    bool isFriend,
    String avatarUrl,
    String createdAt, // temp (instead of DateTime)
    String updatedAt, // temp (instead of DateTime)
    int version
  }) = _Account;

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
}
