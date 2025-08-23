// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'volume_setting_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

VolumeSettingModel _$VolumeSettingModelFromJson(Map<String, dynamic> json) {
  return _VolumeSettingModel.fromJson(json);
}

/// @nodoc
mixin _$VolumeSettingModel {
  double get masterVolume => throw _privateConstructorUsedError;
  bool get isMuted => throw _privateConstructorUsedError;

  /// Serializes this VolumeSettingModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VolumeSettingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VolumeSettingModelCopyWith<VolumeSettingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VolumeSettingModelCopyWith<$Res> {
  factory $VolumeSettingModelCopyWith(
    VolumeSettingModel value,
    $Res Function(VolumeSettingModel) then,
  ) = _$VolumeSettingModelCopyWithImpl<$Res, VolumeSettingModel>;
  @useResult
  $Res call({double masterVolume, bool isMuted});
}

/// @nodoc
class _$VolumeSettingModelCopyWithImpl<$Res, $Val extends VolumeSettingModel>
    implements $VolumeSettingModelCopyWith<$Res> {
  _$VolumeSettingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VolumeSettingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? masterVolume = null, Object? isMuted = null}) {
    return _then(
      _value.copyWith(
            masterVolume: null == masterVolume
                ? _value.masterVolume
                : masterVolume // ignore: cast_nullable_to_non_nullable
                      as double,
            isMuted: null == isMuted
                ? _value.isMuted
                : isMuted // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VolumeSettingModelImplCopyWith<$Res>
    implements $VolumeSettingModelCopyWith<$Res> {
  factory _$$VolumeSettingModelImplCopyWith(
    _$VolumeSettingModelImpl value,
    $Res Function(_$VolumeSettingModelImpl) then,
  ) = __$$VolumeSettingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double masterVolume, bool isMuted});
}

/// @nodoc
class __$$VolumeSettingModelImplCopyWithImpl<$Res>
    extends _$VolumeSettingModelCopyWithImpl<$Res, _$VolumeSettingModelImpl>
    implements _$$VolumeSettingModelImplCopyWith<$Res> {
  __$$VolumeSettingModelImplCopyWithImpl(
    _$VolumeSettingModelImpl _value,
    $Res Function(_$VolumeSettingModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VolumeSettingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? masterVolume = null, Object? isMuted = null}) {
    return _then(
      _$VolumeSettingModelImpl(
        masterVolume: null == masterVolume
            ? _value.masterVolume
            : masterVolume // ignore: cast_nullable_to_non_nullable
                  as double,
        isMuted: null == isMuted
            ? _value.isMuted
            : isMuted // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VolumeSettingModelImpl implements _VolumeSettingModel {
  const _$VolumeSettingModelImpl({
    this.masterVolume = 0.7,
    this.isMuted = false,
  });

  factory _$VolumeSettingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VolumeSettingModelImplFromJson(json);

  @override
  @JsonKey()
  final double masterVolume;
  @override
  @JsonKey()
  final bool isMuted;

  @override
  String toString() {
    return 'VolumeSettingModel(masterVolume: $masterVolume, isMuted: $isMuted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VolumeSettingModelImpl &&
            (identical(other.masterVolume, masterVolume) ||
                other.masterVolume == masterVolume) &&
            (identical(other.isMuted, isMuted) || other.isMuted == isMuted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, masterVolume, isMuted);

  /// Create a copy of VolumeSettingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VolumeSettingModelImplCopyWith<_$VolumeSettingModelImpl> get copyWith =>
      __$$VolumeSettingModelImplCopyWithImpl<_$VolumeSettingModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$VolumeSettingModelImplToJson(this);
  }
}

abstract class _VolumeSettingModel implements VolumeSettingModel {
  const factory _VolumeSettingModel({
    final double masterVolume,
    final bool isMuted,
  }) = _$VolumeSettingModelImpl;

  factory _VolumeSettingModel.fromJson(Map<String, dynamic> json) =
      _$VolumeSettingModelImpl.fromJson;

  @override
  double get masterVolume;
  @override
  bool get isMuted;

  /// Create a copy of VolumeSettingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VolumeSettingModelImplCopyWith<_$VolumeSettingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
