// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Account _$AccountFromJson(Map<String, dynamic> json) {
  return _Account.fromJson(json);
}

/// @nodoc
class _$AccountTearOff {
  const _$AccountTearOff();

// ignore: unused_element
  _Account call(
      {String id,
      String name,
      String description,
      double rating,
      bool isFriend,
      String avatarUrl,
      String createdAt,
      String updatedAt,
      int version}) {
    return _Account(
      id: id,
      name: name,
      description: description,
      rating: rating,
      isFriend: isFriend,
      avatarUrl: avatarUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
      version: version,
    );
  }

// ignore: unused_element
  Account fromJson(Map<String, Object> json) {
    return Account.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Account = _$AccountTearOff();

/// @nodoc
mixin _$Account {
  String get id;
  String get name;
  String get description;
  double get rating;
  bool get isFriend;
  String get avatarUrl;
  String get createdAt; // temp (instead of DateTime)
  String get updatedAt; // temp (instead of DateTime)
  int get version;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $AccountCopyWith<Account> get copyWith;
}

/// @nodoc
abstract class $AccountCopyWith<$Res> {
  factory $AccountCopyWith(Account value, $Res Function(Account) then) =
      _$AccountCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String name,
      String description,
      double rating,
      bool isFriend,
      String avatarUrl,
      String createdAt,
      String updatedAt,
      int version});
}

/// @nodoc
class _$AccountCopyWithImpl<$Res> implements $AccountCopyWith<$Res> {
  _$AccountCopyWithImpl(this._value, this._then);

  final Account _value;
  // ignore: unused_field
  final $Res Function(Account) _then;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object description = freezed,
    Object rating = freezed,
    Object isFriend = freezed,
    Object avatarUrl = freezed,
    Object createdAt = freezed,
    Object updatedAt = freezed,
    Object version = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      description:
          description == freezed ? _value.description : description as String,
      rating: rating == freezed ? _value.rating : rating as double,
      isFriend: isFriend == freezed ? _value.isFriend : isFriend as bool,
      avatarUrl: avatarUrl == freezed ? _value.avatarUrl : avatarUrl as String,
      createdAt: createdAt == freezed ? _value.createdAt : createdAt as String,
      updatedAt: updatedAt == freezed ? _value.updatedAt : updatedAt as String,
      version: version == freezed ? _value.version : version as int,
    ));
  }
}

/// @nodoc
abstract class _$AccountCopyWith<$Res> implements $AccountCopyWith<$Res> {
  factory _$AccountCopyWith(_Account value, $Res Function(_Account) then) =
      __$AccountCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String name,
      String description,
      double rating,
      bool isFriend,
      String avatarUrl,
      String createdAt,
      String updatedAt,
      int version});
}

/// @nodoc
class __$AccountCopyWithImpl<$Res> extends _$AccountCopyWithImpl<$Res>
    implements _$AccountCopyWith<$Res> {
  __$AccountCopyWithImpl(_Account _value, $Res Function(_Account) _then)
      : super(_value, (v) => _then(v as _Account));

  @override
  _Account get _value => super._value as _Account;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object description = freezed,
    Object rating = freezed,
    Object isFriend = freezed,
    Object avatarUrl = freezed,
    Object createdAt = freezed,
    Object updatedAt = freezed,
    Object version = freezed,
  }) {
    return _then(_Account(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      description:
          description == freezed ? _value.description : description as String,
      rating: rating == freezed ? _value.rating : rating as double,
      isFriend: isFriend == freezed ? _value.isFriend : isFriend as bool,
      avatarUrl: avatarUrl == freezed ? _value.avatarUrl : avatarUrl as String,
      createdAt: createdAt == freezed ? _value.createdAt : createdAt as String,
      updatedAt: updatedAt == freezed ? _value.updatedAt : updatedAt as String,
      version: version == freezed ? _value.version : version as int,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Account with DiagnosticableTreeMixin implements _Account {
  const _$_Account(
      {this.id,
      this.name,
      this.description,
      this.rating,
      this.isFriend,
      this.avatarUrl,
      this.createdAt,
      this.updatedAt,
      this.version});

  factory _$_Account.fromJson(Map<String, dynamic> json) =>
      _$_$_AccountFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final double rating;
  @override
  final bool isFriend;
  @override
  final String avatarUrl;
  @override
  final String createdAt;
  @override // temp (instead of DateTime)
  final String updatedAt;
  @override // temp (instead of DateTime)
  final int version;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Account(id: $id, name: $name, description: $description, rating: $rating, isFriend: $isFriend, avatarUrl: $avatarUrl, createdAt: $createdAt, updatedAt: $updatedAt, version: $version)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Account'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('rating', rating))
      ..add(DiagnosticsProperty('isFriend', isFriend))
      ..add(DiagnosticsProperty('avatarUrl', avatarUrl))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('version', version));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Account &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.rating, rating) ||
                const DeepCollectionEquality().equals(other.rating, rating)) &&
            (identical(other.isFriend, isFriend) ||
                const DeepCollectionEquality()
                    .equals(other.isFriend, isFriend)) &&
            (identical(other.avatarUrl, avatarUrl) ||
                const DeepCollectionEquality()
                    .equals(other.avatarUrl, avatarUrl)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.version, version) ||
                const DeepCollectionEquality().equals(other.version, version)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(rating) ^
      const DeepCollectionEquality().hash(isFriend) ^
      const DeepCollectionEquality().hash(avatarUrl) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(version);

  @JsonKey(ignore: true)
  @override
  _$AccountCopyWith<_Account> get copyWith =>
      __$AccountCopyWithImpl<_Account>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_AccountToJson(this);
  }
}

abstract class _Account implements Account {
  const factory _Account(
      {String id,
      String name,
      String description,
      double rating,
      bool isFriend,
      String avatarUrl,
      String createdAt,
      String updatedAt,
      int version}) = _$_Account;

  factory _Account.fromJson(Map<String, dynamic> json) = _$_Account.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  double get rating;
  @override
  bool get isFriend;
  @override
  String get avatarUrl;
  @override
  String get createdAt;
  @override // temp (instead of DateTime)
  String get updatedAt;
  @override // temp (instead of DateTime)
  int get version;
  @override
  @JsonKey(ignore: true)
  _$AccountCopyWith<_Account> get copyWith;
}
