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

/// @nodoc
mixin _$AudioDevice {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get isVirtualCable => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

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
  $Res call({String id, String name, bool isVirtualCable, String? description});
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
    Object? description = freezed,
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
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
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
  $Res call({String id, String name, bool isVirtualCable, String? description});
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
    Object? description = freezed,
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
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$AudioDeviceImpl extends _AudioDevice {
  const _$AudioDeviceImpl({
    required this.id,
    required this.name,
    required this.isVirtualCable,
    this.description,
  }) : super._();

  @override
  final String id;
  @override
  final String name;
  @override
  final bool isVirtualCable;
  @override
  final String? description;

  @override
  String toString() {
    return 'AudioDevice(id: $id, name: $name, isVirtualCable: $isVirtualCable, description: $description)';
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
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, isVirtualCable, description);

  /// Create a copy of AudioDevice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioDeviceImplCopyWith<_$AudioDeviceImpl> get copyWith =>
      __$$AudioDeviceImplCopyWithImpl<_$AudioDeviceImpl>(this, _$identity);
}

abstract class _AudioDevice extends AudioDevice {
  const factory _AudioDevice({
    required final String id,
    required final String name,
    required final bool isVirtualCable,
    final String? description,
  }) = _$AudioDeviceImpl;
  const _AudioDevice._() : super._();

  @override
  String get id;
  @override
  String get name;
  @override
  bool get isVirtualCable;
  @override
  String? get description;

  /// Create a copy of AudioDevice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AudioDeviceImplCopyWith<_$AudioDeviceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
