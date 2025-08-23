// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'keyboard_shortcut_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

KeyboardShortcutSetting _$KeyboardShortcutSettingFromJson(
  Map<String, dynamic> json,
) {
  return _KeyboardShortcutSetting.fromJson(json);
}

/// @nodoc
mixin _$KeyboardShortcutSetting {
  String get quickSoundsShortcut => throw _privateConstructorUsedError;

  /// Serializes this KeyboardShortcutSetting to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KeyboardShortcutSetting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KeyboardShortcutSettingCopyWith<KeyboardShortcutSetting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeyboardShortcutSettingCopyWith<$Res> {
  factory $KeyboardShortcutSettingCopyWith(
    KeyboardShortcutSetting value,
    $Res Function(KeyboardShortcutSetting) then,
  ) = _$KeyboardShortcutSettingCopyWithImpl<$Res, KeyboardShortcutSetting>;
  @useResult
  $Res call({String quickSoundsShortcut});
}

/// @nodoc
class _$KeyboardShortcutSettingCopyWithImpl<
  $Res,
  $Val extends KeyboardShortcutSetting
>
    implements $KeyboardShortcutSettingCopyWith<$Res> {
  _$KeyboardShortcutSettingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KeyboardShortcutSetting
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? quickSoundsShortcut = null}) {
    return _then(
      _value.copyWith(
            quickSoundsShortcut: null == quickSoundsShortcut
                ? _value.quickSoundsShortcut
                : quickSoundsShortcut // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$KeyboardShortcutSettingImplCopyWith<$Res>
    implements $KeyboardShortcutSettingCopyWith<$Res> {
  factory _$$KeyboardShortcutSettingImplCopyWith(
    _$KeyboardShortcutSettingImpl value,
    $Res Function(_$KeyboardShortcutSettingImpl) then,
  ) = __$$KeyboardShortcutSettingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String quickSoundsShortcut});
}

/// @nodoc
class __$$KeyboardShortcutSettingImplCopyWithImpl<$Res>
    extends
        _$KeyboardShortcutSettingCopyWithImpl<
          $Res,
          _$KeyboardShortcutSettingImpl
        >
    implements _$$KeyboardShortcutSettingImplCopyWith<$Res> {
  __$$KeyboardShortcutSettingImplCopyWithImpl(
    _$KeyboardShortcutSettingImpl _value,
    $Res Function(_$KeyboardShortcutSettingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of KeyboardShortcutSetting
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? quickSoundsShortcut = null}) {
    return _then(
      _$KeyboardShortcutSettingImpl(
        quickSoundsShortcut: null == quickSoundsShortcut
            ? _value.quickSoundsShortcut
            : quickSoundsShortcut // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$KeyboardShortcutSettingImpl implements _KeyboardShortcutSetting {
  const _$KeyboardShortcutSettingImpl({this.quickSoundsShortcut = 'CMD+0'});

  factory _$KeyboardShortcutSettingImpl.fromJson(Map<String, dynamic> json) =>
      _$$KeyboardShortcutSettingImplFromJson(json);

  @override
  @JsonKey()
  final String quickSoundsShortcut;

  @override
  String toString() {
    return 'KeyboardShortcutSetting(quickSoundsShortcut: $quickSoundsShortcut)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KeyboardShortcutSettingImpl &&
            (identical(other.quickSoundsShortcut, quickSoundsShortcut) ||
                other.quickSoundsShortcut == quickSoundsShortcut));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, quickSoundsShortcut);

  /// Create a copy of KeyboardShortcutSetting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KeyboardShortcutSettingImplCopyWith<_$KeyboardShortcutSettingImpl>
  get copyWith =>
      __$$KeyboardShortcutSettingImplCopyWithImpl<
        _$KeyboardShortcutSettingImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KeyboardShortcutSettingImplToJson(this);
  }
}

abstract class _KeyboardShortcutSetting implements KeyboardShortcutSetting {
  const factory _KeyboardShortcutSetting({final String quickSoundsShortcut}) =
      _$KeyboardShortcutSettingImpl;

  factory _KeyboardShortcutSetting.fromJson(Map<String, dynamic> json) =
      _$KeyboardShortcutSettingImpl.fromJson;

  @override
  String get quickSoundsShortcut;

  /// Create a copy of KeyboardShortcutSetting
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KeyboardShortcutSettingImplCopyWith<_$KeyboardShortcutSettingImpl>
  get copyWith => throw _privateConstructorUsedError;
}
