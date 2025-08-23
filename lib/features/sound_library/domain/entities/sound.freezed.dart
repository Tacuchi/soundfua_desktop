// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sound.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Sound _$SoundFromJson(Map<String, dynamic> json) {
  return _Sound.fromJson(json);
}

/// @nodoc
mixin _$Sound {
  int? get id => throw _privateConstructorUsedError;
  String get filePath => throw _privateConstructorUsedError;
  String get alias => throw _privateConstructorUsedError;
  DateTime get addedOn => throw _privateConstructorUsedError;

  /// Serializes this Sound to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Sound
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SoundCopyWith<Sound> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SoundCopyWith<$Res> {
  factory $SoundCopyWith(Sound value, $Res Function(Sound) then) =
      _$SoundCopyWithImpl<$Res, Sound>;
  @useResult
  $Res call({int? id, String filePath, String alias, DateTime addedOn});
}

/// @nodoc
class _$SoundCopyWithImpl<$Res, $Val extends Sound>
    implements $SoundCopyWith<$Res> {
  _$SoundCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Sound
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? filePath = null,
    Object? alias = null,
    Object? addedOn = null,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int?,
            filePath: null == filePath
                ? _value.filePath
                : filePath // ignore: cast_nullable_to_non_nullable
                      as String,
            alias: null == alias
                ? _value.alias
                : alias // ignore: cast_nullable_to_non_nullable
                      as String,
            addedOn: null == addedOn
                ? _value.addedOn
                : addedOn // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SoundImplCopyWith<$Res> implements $SoundCopyWith<$Res> {
  factory _$$SoundImplCopyWith(
    _$SoundImpl value,
    $Res Function(_$SoundImpl) then,
  ) = __$$SoundImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String filePath, String alias, DateTime addedOn});
}

/// @nodoc
class __$$SoundImplCopyWithImpl<$Res>
    extends _$SoundCopyWithImpl<$Res, _$SoundImpl>
    implements _$$SoundImplCopyWith<$Res> {
  __$$SoundImplCopyWithImpl(
    _$SoundImpl _value,
    $Res Function(_$SoundImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Sound
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? filePath = null,
    Object? alias = null,
    Object? addedOn = null,
  }) {
    return _then(
      _$SoundImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        filePath: null == filePath
            ? _value.filePath
            : filePath // ignore: cast_nullable_to_non_nullable
                  as String,
        alias: null == alias
            ? _value.alias
            : alias // ignore: cast_nullable_to_non_nullable
                  as String,
        addedOn: null == addedOn
            ? _value.addedOn
            : addedOn // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SoundImpl implements _Sound {
  const _$SoundImpl({
    this.id,
    required this.filePath,
    required this.alias,
    required this.addedOn,
  });

  factory _$SoundImpl.fromJson(Map<String, dynamic> json) =>
      _$$SoundImplFromJson(json);

  @override
  final int? id;
  @override
  final String filePath;
  @override
  final String alias;
  @override
  final DateTime addedOn;

  @override
  String toString() {
    return 'Sound(id: $id, filePath: $filePath, alias: $alias, addedOn: $addedOn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SoundImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.alias, alias) || other.alias == alias) &&
            (identical(other.addedOn, addedOn) || other.addedOn == addedOn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, filePath, alias, addedOn);

  /// Create a copy of Sound
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SoundImplCopyWith<_$SoundImpl> get copyWith =>
      __$$SoundImplCopyWithImpl<_$SoundImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SoundImplToJson(this);
  }
}

abstract class _Sound implements Sound {
  const factory _Sound({
    final int? id,
    required final String filePath,
    required final String alias,
    required final DateTime addedOn,
  }) = _$SoundImpl;

  factory _Sound.fromJson(Map<String, dynamic> json) = _$SoundImpl.fromJson;

  @override
  int? get id;
  @override
  String get filePath;
  @override
  String get alias;
  @override
  DateTime get addedOn;

  /// Create a copy of Sound
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SoundImplCopyWith<_$SoundImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
