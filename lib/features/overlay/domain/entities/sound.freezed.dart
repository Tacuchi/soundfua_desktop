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

/// @nodoc
mixin _$Sound {
  int? get id => throw _privateConstructorUsedError;
  String get fileName => throw _privateConstructorUsedError;
  String get filePath => throw _privateConstructorUsedError;
  int get fileSize => throw _privateConstructorUsedError;
  DateTime get addedOn => throw _privateConstructorUsedError;
  DateTime get lastModified => throw _privateConstructorUsedError;
  int get playCount => throw _privateConstructorUsedError;
  DateTime? get lastPlayedAt => throw _privateConstructorUsedError;

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
  $Res call({
    int? id,
    String fileName,
    String filePath,
    int fileSize,
    DateTime addedOn,
    DateTime lastModified,
    int playCount,
    DateTime? lastPlayedAt,
  });
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
    Object? fileName = null,
    Object? filePath = null,
    Object? fileSize = null,
    Object? addedOn = null,
    Object? lastModified = null,
    Object? playCount = null,
    Object? lastPlayedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int?,
            fileName: null == fileName
                ? _value.fileName
                : fileName // ignore: cast_nullable_to_non_nullable
                      as String,
            filePath: null == filePath
                ? _value.filePath
                : filePath // ignore: cast_nullable_to_non_nullable
                      as String,
            fileSize: null == fileSize
                ? _value.fileSize
                : fileSize // ignore: cast_nullable_to_non_nullable
                      as int,
            addedOn: null == addedOn
                ? _value.addedOn
                : addedOn // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            lastModified: null == lastModified
                ? _value.lastModified
                : lastModified // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            playCount: null == playCount
                ? _value.playCount
                : playCount // ignore: cast_nullable_to_non_nullable
                      as int,
            lastPlayedAt: freezed == lastPlayedAt
                ? _value.lastPlayedAt
                : lastPlayedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
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
  $Res call({
    int? id,
    String fileName,
    String filePath,
    int fileSize,
    DateTime addedOn,
    DateTime lastModified,
    int playCount,
    DateTime? lastPlayedAt,
  });
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
    Object? fileName = null,
    Object? filePath = null,
    Object? fileSize = null,
    Object? addedOn = null,
    Object? lastModified = null,
    Object? playCount = null,
    Object? lastPlayedAt = freezed,
  }) {
    return _then(
      _$SoundImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        fileName: null == fileName
            ? _value.fileName
            : fileName // ignore: cast_nullable_to_non_nullable
                  as String,
        filePath: null == filePath
            ? _value.filePath
            : filePath // ignore: cast_nullable_to_non_nullable
                  as String,
        fileSize: null == fileSize
            ? _value.fileSize
            : fileSize // ignore: cast_nullable_to_non_nullable
                  as int,
        addedOn: null == addedOn
            ? _value.addedOn
            : addedOn // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        lastModified: null == lastModified
            ? _value.lastModified
            : lastModified // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        playCount: null == playCount
            ? _value.playCount
            : playCount // ignore: cast_nullable_to_non_nullable
                  as int,
        lastPlayedAt: freezed == lastPlayedAt
            ? _value.lastPlayedAt
            : lastPlayedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$SoundImpl implements _Sound {
  const _$SoundImpl({
    this.id,
    required this.fileName,
    required this.filePath,
    required this.fileSize,
    required this.addedOn,
    required this.lastModified,
    this.playCount = 0,
    this.lastPlayedAt,
  });

  @override
  final int? id;
  @override
  final String fileName;
  @override
  final String filePath;
  @override
  final int fileSize;
  @override
  final DateTime addedOn;
  @override
  final DateTime lastModified;
  @override
  @JsonKey()
  final int playCount;
  @override
  final DateTime? lastPlayedAt;

  @override
  String toString() {
    return 'Sound(id: $id, fileName: $fileName, filePath: $filePath, fileSize: $fileSize, addedOn: $addedOn, lastModified: $lastModified, playCount: $playCount, lastPlayedAt: $lastPlayedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SoundImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.fileSize, fileSize) ||
                other.fileSize == fileSize) &&
            (identical(other.addedOn, addedOn) || other.addedOn == addedOn) &&
            (identical(other.lastModified, lastModified) ||
                other.lastModified == lastModified) &&
            (identical(other.playCount, playCount) ||
                other.playCount == playCount) &&
            (identical(other.lastPlayedAt, lastPlayedAt) ||
                other.lastPlayedAt == lastPlayedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    fileName,
    filePath,
    fileSize,
    addedOn,
    lastModified,
    playCount,
    lastPlayedAt,
  );

  /// Create a copy of Sound
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SoundImplCopyWith<_$SoundImpl> get copyWith =>
      __$$SoundImplCopyWithImpl<_$SoundImpl>(this, _$identity);
}

abstract class _Sound implements Sound {
  const factory _Sound({
    final int? id,
    required final String fileName,
    required final String filePath,
    required final int fileSize,
    required final DateTime addedOn,
    required final DateTime lastModified,
    final int playCount,
    final DateTime? lastPlayedAt,
  }) = _$SoundImpl;

  @override
  int? get id;
  @override
  String get fileName;
  @override
  String get filePath;
  @override
  int get fileSize;
  @override
  DateTime get addedOn;
  @override
  DateTime get lastModified;
  @override
  int get playCount;
  @override
  DateTime? get lastPlayedAt;

  /// Create a copy of Sound
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SoundImplCopyWith<_$SoundImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
