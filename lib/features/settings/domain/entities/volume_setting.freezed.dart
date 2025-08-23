// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'volume_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

VolumeSetting _$VolumeSettingFromJson(Map<String, dynamic> json) {
  return _VolumeSetting.fromJson(json);
}

/// @nodoc
mixin _$VolumeSetting {
  double get masterVolume => throw _privateConstructorUsedError;
  bool get isMuted => throw _privateConstructorUsedError;

  /// Serializes this VolumeSetting to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VolumeSetting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VolumeSettingCopyWith<VolumeSetting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VolumeSettingCopyWith<$Res> {
  factory $VolumeSettingCopyWith(
    VolumeSetting value,
    $Res Function(VolumeSetting) then,
  ) = _$VolumeSettingCopyWithImpl<$Res, VolumeSetting>;
  @useResult
  $Res call({double masterVolume, bool isMuted});
}

/// @nodoc
class _$VolumeSettingCopyWithImpl<$Res, $Val extends VolumeSetting>
    implements $VolumeSettingCopyWith<$Res> {
  _$VolumeSettingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VolumeSetting
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
abstract class _$$VolumeSettingImplCopyWith<$Res>
    implements $VolumeSettingCopyWith<$Res> {
  factory _$$VolumeSettingImplCopyWith(
    _$VolumeSettingImpl value,
    $Res Function(_$VolumeSettingImpl) then,
  ) = __$$VolumeSettingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double masterVolume, bool isMuted});
}

/// @nodoc
class __$$VolumeSettingImplCopyWithImpl<$Res>
    extends _$VolumeSettingCopyWithImpl<$Res, _$VolumeSettingImpl>
    implements _$$VolumeSettingImplCopyWith<$Res> {
  __$$VolumeSettingImplCopyWithImpl(
    _$VolumeSettingImpl _value,
    $Res Function(_$VolumeSettingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VolumeSetting
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? masterVolume = null, Object? isMuted = null}) {
    return _then(
      _$VolumeSettingImpl(
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
class _$VolumeSettingImpl implements _VolumeSetting {
  const _$VolumeSettingImpl({this.masterVolume = 0.7, this.isMuted = false});

  factory _$VolumeSettingImpl.fromJson(Map<String, dynamic> json) =>
      _$$VolumeSettingImplFromJson(json);

  @override
  @JsonKey()
  final double masterVolume;
  @override
  @JsonKey()
  final bool isMuted;

  @override
  String toString() {
    return 'VolumeSetting(masterVolume: $masterVolume, isMuted: $isMuted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VolumeSettingImpl &&
            (identical(other.masterVolume, masterVolume) ||
                other.masterVolume == masterVolume) &&
            (identical(other.isMuted, isMuted) || other.isMuted == isMuted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, masterVolume, isMuted);

  /// Create a copy of VolumeSetting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VolumeSettingImplCopyWith<_$VolumeSettingImpl> get copyWith =>
      __$$VolumeSettingImplCopyWithImpl<_$VolumeSettingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VolumeSettingImplToJson(this);
  }
}

abstract class _VolumeSetting implements VolumeSetting {
  const factory _VolumeSetting({
    final double masterVolume,
    final bool isMuted,
  }) = _$VolumeSettingImpl;

  factory _VolumeSetting.fromJson(Map<String, dynamic> json) =
      _$VolumeSettingImpl.fromJson;

  @override
  double get masterVolume;
  @override
  bool get isMuted;

  /// Create a copy of VolumeSetting
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VolumeSettingImplCopyWith<_$VolumeSettingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
