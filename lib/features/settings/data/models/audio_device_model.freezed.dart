// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_device_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AudioDeviceModel _$AudioDeviceModelFromJson(Map<String, dynamic> json) {
  return _AudioDeviceModel.fromJson(json);
}

/// @nodoc
mixin _$AudioDeviceModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get isVirtualCable => throw _privateConstructorUsedError;
  bool get isDefault => throw _privateConstructorUsedError;
  bool get isSelected => throw _privateConstructorUsedError;

  /// Serializes this AudioDeviceModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AudioDeviceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AudioDeviceModelCopyWith<AudioDeviceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioDeviceModelCopyWith<$Res> {
  factory $AudioDeviceModelCopyWith(
    AudioDeviceModel value,
    $Res Function(AudioDeviceModel) then,
  ) = _$AudioDeviceModelCopyWithImpl<$Res, AudioDeviceModel>;
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
class _$AudioDeviceModelCopyWithImpl<$Res, $Val extends AudioDeviceModel>
    implements $AudioDeviceModelCopyWith<$Res> {
  _$AudioDeviceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AudioDeviceModel
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
abstract class _$$AudioDeviceModelImplCopyWith<$Res>
    implements $AudioDeviceModelCopyWith<$Res> {
  factory _$$AudioDeviceModelImplCopyWith(
    _$AudioDeviceModelImpl value,
    $Res Function(_$AudioDeviceModelImpl) then,
  ) = __$$AudioDeviceModelImplCopyWithImpl<$Res>;
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
class __$$AudioDeviceModelImplCopyWithImpl<$Res>
    extends _$AudioDeviceModelCopyWithImpl<$Res, _$AudioDeviceModelImpl>
    implements _$$AudioDeviceModelImplCopyWith<$Res> {
  __$$AudioDeviceModelImplCopyWithImpl(
    _$AudioDeviceModelImpl _value,
    $Res Function(_$AudioDeviceModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AudioDeviceModel
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
      _$AudioDeviceModelImpl(
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
class _$AudioDeviceModelImpl implements _AudioDeviceModel {
  const _$AudioDeviceModelImpl({
    required this.id,
    required this.name,
    this.isVirtualCable = false,
    this.isDefault = false,
    this.isSelected = false,
  });

  factory _$AudioDeviceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AudioDeviceModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final bool isVirtualCable;
  @override
  @JsonKey()
  final bool isDefault;
  @override
  @JsonKey()
  final bool isSelected;

  @override
  String toString() {
    return 'AudioDeviceModel(id: $id, name: $name, isVirtualCable: $isVirtualCable, isDefault: $isDefault, isSelected: $isSelected)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioDeviceModelImpl &&
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

  /// Create a copy of AudioDeviceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioDeviceModelImplCopyWith<_$AudioDeviceModelImpl> get copyWith =>
      __$$AudioDeviceModelImplCopyWithImpl<_$AudioDeviceModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AudioDeviceModelImplToJson(this);
  }
}

abstract class _AudioDeviceModel implements AudioDeviceModel {
  const factory _AudioDeviceModel({
    required final String id,
    required final String name,
    final bool isVirtualCable,
    final bool isDefault,
    final bool isSelected,
  }) = _$AudioDeviceModelImpl;

  factory _AudioDeviceModel.fromJson(Map<String, dynamic> json) =
      _$AudioDeviceModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  bool get isVirtualCable;
  @override
  bool get isDefault;
  @override
  bool get isSelected;

  /// Create a copy of AudioDeviceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AudioDeviceModelImplCopyWith<_$AudioDeviceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
