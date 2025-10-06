// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sound_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SoundModel _$SoundModelFromJson(Map<String, dynamic> json) {
  return _SoundModel.fromJson(json);
}

/// @nodoc
mixin _$SoundModel {
  int? get id => throw _privateConstructorUsedError;
  String get fileName => throw _privateConstructorUsedError;
  String get filePath => throw _privateConstructorUsedError;
  int get fileSize => throw _privateConstructorUsedError;
  DateTime get addedOn => throw _privateConstructorUsedError;
  DateTime get lastModified => throw _privateConstructorUsedError;
  int get playCount => throw _privateConstructorUsedError;
  DateTime? get lastPlayedAt => throw _privateConstructorUsedError;

  /// Serializes this SoundModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SoundModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SoundModelCopyWith<SoundModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SoundModelCopyWith<$Res> {
  factory $SoundModelCopyWith(
    SoundModel value,
    $Res Function(SoundModel) then,
  ) = _$SoundModelCopyWithImpl<$Res, SoundModel>;
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
class _$SoundModelCopyWithImpl<$Res, $Val extends SoundModel>
    implements $SoundModelCopyWith<$Res> {
  _$SoundModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SoundModel
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
abstract class _$$SoundModelImplCopyWith<$Res>
    implements $SoundModelCopyWith<$Res> {
  factory _$$SoundModelImplCopyWith(
    _$SoundModelImpl value,
    $Res Function(_$SoundModelImpl) then,
  ) = __$$SoundModelImplCopyWithImpl<$Res>;
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
class __$$SoundModelImplCopyWithImpl<$Res>
    extends _$SoundModelCopyWithImpl<$Res, _$SoundModelImpl>
    implements _$$SoundModelImplCopyWith<$Res> {
  __$$SoundModelImplCopyWithImpl(
    _$SoundModelImpl _value,
    $Res Function(_$SoundModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SoundModel
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
      _$SoundModelImpl(
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
@JsonSerializable()
class _$SoundModelImpl extends _SoundModel {
  const _$SoundModelImpl({
    this.id,
    required this.fileName,
    required this.filePath,
    required this.fileSize,
    required this.addedOn,
    required this.lastModified,
    this.playCount = 0,
    this.lastPlayedAt,
  }) : super._();

  factory _$SoundModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SoundModelImplFromJson(json);

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
    return 'SoundModel(id: $id, fileName: $fileName, filePath: $filePath, fileSize: $fileSize, addedOn: $addedOn, lastModified: $lastModified, playCount: $playCount, lastPlayedAt: $lastPlayedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SoundModelImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of SoundModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SoundModelImplCopyWith<_$SoundModelImpl> get copyWith =>
      __$$SoundModelImplCopyWithImpl<_$SoundModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SoundModelImplToJson(this);
  }
}

abstract class _SoundModel extends SoundModel {
  const factory _SoundModel({
    final int? id,
    required final String fileName,
    required final String filePath,
    required final int fileSize,
    required final DateTime addedOn,
    required final DateTime lastModified,
    final int playCount,
    final DateTime? lastPlayedAt,
  }) = _$SoundModelImpl;
  const _SoundModel._() : super._();

  factory _SoundModel.fromJson(Map<String, dynamic> json) =
      _$SoundModelImpl.fromJson;

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

  /// Create a copy of SoundModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SoundModelImplCopyWith<_$SoundModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
