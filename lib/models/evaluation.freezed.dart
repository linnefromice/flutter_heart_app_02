// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'evaluation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Evaluation _$EvaluationFromJson(Map<String, dynamic> json) {
  return _Evaluation.fromJson(json);
}

/// @nodoc
class _$EvaluationTearOff {
  const _$EvaluationTearOff();

// ignore: unused_element
  _Evaluation call(
      {String id,
      String userId,
      double rating,
      String createdDate,
      DateTime createdAt}) {
    return _Evaluation(
      id: id,
      userId: userId,
      rating: rating,
      createdDate: createdDate,
      createdAt: createdAt,
    );
  }

// ignore: unused_element
  Evaluation fromJson(Map<String, Object> json) {
    return Evaluation.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Evaluation = _$EvaluationTearOff();

/// @nodoc
mixin _$Evaluation {
  String get id;
  String get userId;
  double get rating;
  String get createdDate;
  DateTime get createdAt;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $EvaluationCopyWith<Evaluation> get copyWith;
}

/// @nodoc
abstract class $EvaluationCopyWith<$Res> {
  factory $EvaluationCopyWith(
          Evaluation value, $Res Function(Evaluation) then) =
      _$EvaluationCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String userId,
      double rating,
      String createdDate,
      DateTime createdAt});
}

/// @nodoc
class _$EvaluationCopyWithImpl<$Res> implements $EvaluationCopyWith<$Res> {
  _$EvaluationCopyWithImpl(this._value, this._then);

  final Evaluation _value;
  // ignore: unused_field
  final $Res Function(Evaluation) _then;

  @override
  $Res call({
    Object id = freezed,
    Object userId = freezed,
    Object rating = freezed,
    Object createdDate = freezed,
    Object createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      userId: userId == freezed ? _value.userId : userId as String,
      rating: rating == freezed ? _value.rating : rating as double,
      createdDate:
          createdDate == freezed ? _value.createdDate : createdDate as String,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$EvaluationCopyWith<$Res> implements $EvaluationCopyWith<$Res> {
  factory _$EvaluationCopyWith(
          _Evaluation value, $Res Function(_Evaluation) then) =
      __$EvaluationCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String userId,
      double rating,
      String createdDate,
      DateTime createdAt});
}

/// @nodoc
class __$EvaluationCopyWithImpl<$Res> extends _$EvaluationCopyWithImpl<$Res>
    implements _$EvaluationCopyWith<$Res> {
  __$EvaluationCopyWithImpl(
      _Evaluation _value, $Res Function(_Evaluation) _then)
      : super(_value, (v) => _then(v as _Evaluation));

  @override
  _Evaluation get _value => super._value as _Evaluation;

  @override
  $Res call({
    Object id = freezed,
    Object userId = freezed,
    Object rating = freezed,
    Object createdDate = freezed,
    Object createdAt = freezed,
  }) {
    return _then(_Evaluation(
      id: id == freezed ? _value.id : id as String,
      userId: userId == freezed ? _value.userId : userId as String,
      rating: rating == freezed ? _value.rating : rating as double,
      createdDate:
          createdDate == freezed ? _value.createdDate : createdDate as String,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Evaluation with DiagnosticableTreeMixin implements _Evaluation {
  const _$_Evaluation(
      {this.id, this.userId, this.rating, this.createdDate, this.createdAt});

  factory _$_Evaluation.fromJson(Map<String, dynamic> json) =>
      _$_$_EvaluationFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final double rating;
  @override
  final String createdDate;
  @override
  final DateTime createdAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Evaluation(id: $id, userId: $userId, rating: $rating, createdDate: $createdDate, createdAt: $createdAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Evaluation'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('rating', rating))
      ..add(DiagnosticsProperty('createdDate', createdDate))
      ..add(DiagnosticsProperty('createdAt', createdAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Evaluation &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.rating, rating) ||
                const DeepCollectionEquality().equals(other.rating, rating)) &&
            (identical(other.createdDate, createdDate) ||
                const DeepCollectionEquality()
                    .equals(other.createdDate, createdDate)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(rating) ^
      const DeepCollectionEquality().hash(createdDate) ^
      const DeepCollectionEquality().hash(createdAt);

  @JsonKey(ignore: true)
  @override
  _$EvaluationCopyWith<_Evaluation> get copyWith =>
      __$EvaluationCopyWithImpl<_Evaluation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_EvaluationToJson(this);
  }
}

abstract class _Evaluation implements Evaluation {
  const factory _Evaluation(
      {String id,
      String userId,
      double rating,
      String createdDate,
      DateTime createdAt}) = _$_Evaluation;

  factory _Evaluation.fromJson(Map<String, dynamic> json) =
      _$_Evaluation.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  double get rating;
  @override
  String get createdDate;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$EvaluationCopyWith<_Evaluation> get copyWith;
}
