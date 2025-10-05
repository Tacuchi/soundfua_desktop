// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_device.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AudioDevice _$AudioDeviceFromJson(Map<String, dynamic> json) {
  return _AudioDevice.fromJson(json);
}

/// @nodoc
mixin _$AudioDevice {
  /// Unique identifier for the device
  String get id => throw _privateConstructorUsedError;

  /// Human-readable name of the device
  String get name => throw _privateConstructorUsedError;

  /// Whether this is a virtual audio cable (VB-CABLE, etc.)
  bool get isVirtualCable => throw _privateConstructorUsedError;

  /// Whether this is the system default device
  bool get isDefault => throw _privateConstructorUsedError;

  /// Whether this is currently selected in the app
  bool get isSelected => throw _privateConstructorUsedError;

  /// Serializes this AudioDevice to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AudioDevice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AudioDeviceCopyWith<AudioDevice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioDeviceCopyWith<$Res> {
  factory $AudioDeviceCopyWith(
    AudioDevice value,
    $Res Function(AudioDevice) then,
  ) = _$AudioDeviceCopyWithImpl<$Res, AudioDevice>;
  @useResult
  $Res call({
    String id,
    String name,
    bool isVirtualCable,
    bool isDefault,
    bool isSelected,
  });
}

/// @nodoc
class _$AudioDeviceCopyWithImpl<$Res, $Val extends AudioDevice>
    implements $AudioDeviceCopyWith<$Res> {
  _$AudioDeviceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AudioDevice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? isVirtualCable = null,
    Object? isDefault = null,
    Object? isSelected = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            isVirtualCable: null == isVirtualCable
                ? _value.isVirtualCable
                : isVirtualCable // ignore: cast_nullable_to_non_nullable
                      as bool,
            isDefault: null == isDefault
                ? _value.isDefault
                : isDefault // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSelected: null == isSelected
                ? _value.isSelected
                : isSelected // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AudioDeviceImplCopyWith<$Res>
    implements $AudioDeviceCopyWith<$Res> {
  factory _$$AudioDeviceImplCopyWith(
    _$AudioDeviceImpl value,
    $Res Function(_$AudioDeviceImpl) then,
  ) = __$$AudioDeviceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    bool isVirtualCable,
    bool isDefault,
    bool isSelected,
  });
}

/// @nodoc
class __$$AudioDeviceImplCopyWithImpl<$Res>
    extends _$AudioDeviceCopyWithImpl<$Res, _$AudioDeviceImpl>
    implements _$$AudioDeviceImplCopyWith<$Res> {
  __$$AudioDeviceImplCopyWithImpl(
    _$AudioDeviceImpl _value,
    $Res Function(_$AudioDeviceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AudioDevice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? isVirtualCable = null,
    Object? isDefault = null,
    Object? isSelected = null,
  }) {
    return _then(
      _$AudioDeviceImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        isVirtualCable: null == isVirtualCable
            ? _value.isVirtualCable
            : isVirtualCable // ignore: cast_nullable_to_non_nullable
                  as bool,
        isDefault: null == isDefault
            ? _value.isDefault
            : isDefault // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSelected: null == isSelected
            ? _value.isSelected
            : isSelected // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AudioDeviceImpl implements _AudioDevice {
  const _$AudioDeviceImpl({
    required this.id,
    required this.name,
    this.isVirtualCable = false,
    this.isDefault = false,
    this.isSelected = false,
  });

  factory _$AudioDeviceImpl.fromJson(Map<String, dynamic> json) =>
      _$$AudioDeviceImplFromJson(json);

  /// Unique identifier for the device
  @override
  final String id;

  /// Human-readable name of the device
  @override
  final String name;

  /// Whether this is a virtual audio cable (VB-CABLE, etc.)
  @override
  @JsonKey()
  final bool isVirtualCable;

  /// Whether this is the system default device
  @override
  @JsonKey()
  final bool isDefault;

  /// Whether this is currently selected in the app
  @override
  @JsonKey()
  final bool isSelected;

  @override
  String toString() {
    return 'AudioDevice(id: $id, name: $name, isVirtualCable: $isVirtualCable, isDefault: $isDefault, isSelected: $isSelected)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioDeviceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isVirtualCable, isVirtualCable) ||
                other.isVirtualCable == isVirtualCable) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.isSelected, isSelected) ||
                other.isSelected == isSelected));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, isVirtualCable, isDefault, isSelected);

  /// Create a copy of AudioDevice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioDeviceImplCopyWith<_$AudioDeviceImpl> get copyWith =>
      __$$AudioDeviceImplCopyWithImpl<_$AudioDeviceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AudioDeviceImplToJson(this);
  }
}

abstract class _AudioDevice implements AudioDevice {
  const factory _AudioDevice({
    required final String id,
    required final String name,
    final bool isVirtualCable,
    final bool isDefault,
    final bool isSelected,
  }) = _$AudioDeviceImpl;

  factory _AudioDevice.fromJson(Map<String, dynamic> json) =
      _$AudioDeviceImpl.fromJson;

  /// Unique identifier for the device
  @override
  String get id;

  /// Human-readable name of the device
  @override
  String get name;

  /// Whether this is a virtual audio cable (VB-CABLE, etc.)
  @override
  bool get isVirtualCable;

  /// Whether this is the system default device
  @override
  bool get isDefault;

  /// Whether this is currently selected in the app
  @override
  bool get isSelected;

  /// Create a copy of AudioDevice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AudioDeviceImplCopyWith<_$AudioDeviceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
