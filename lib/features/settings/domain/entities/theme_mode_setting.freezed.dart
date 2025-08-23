// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_mode_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ThemeModeSetting _$ThemeModeSettingFromJson(Map<String, dynamic> json) {
  return _ThemeModeSetting.fromJson(json);
}

/// @nodoc
mixin _$ThemeModeSetting {
  AppThemeMode get themeMode => throw _privateConstructorUsedError;
  bool get isSystemDarkMode => throw _privateConstructorUsedError;

  /// Serializes this ThemeModeSetting to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ThemeModeSetting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ThemeModeSettingCopyWith<ThemeModeSetting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemeModeSettingCopyWith<$Res> {
  factory $ThemeModeSettingCopyWith(
    ThemeModeSetting value,
    $Res Function(ThemeModeSetting) then,
  ) = _$ThemeModeSettingCopyWithImpl<$Res, ThemeModeSetting>;
  @useResult
  $Res call({AppThemeMode themeMode, bool isSystemDarkMode});
}

/// @nodoc
class _$ThemeModeSettingCopyWithImpl<$Res, $Val extends ThemeModeSetting>
    implements $ThemeModeSettingCopyWith<$Res> {
  _$ThemeModeSettingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ThemeModeSetting
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? themeMode = null, Object? isSystemDarkMode = null}) {
    return _then(
      _value.copyWith(
            themeMode: null == themeMode
                ? _value.themeMode
                : themeMode // ignore: cast_nullable_to_non_nullable
                      as AppThemeMode,
            isSystemDarkMode: null == isSystemDarkMode
                ? _value.isSystemDarkMode
                : isSystemDarkMode // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ThemeModeSettingImplCopyWith<$Res>
    implements $ThemeModeSettingCopyWith<$Res> {
  factory _$$ThemeModeSettingImplCopyWith(
    _$ThemeModeSettingImpl value,
    $Res Function(_$ThemeModeSettingImpl) then,
  ) = __$$ThemeModeSettingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AppThemeMode themeMode, bool isSystemDarkMode});
}

/// @nodoc
class __$$ThemeModeSettingImplCopyWithImpl<$Res>
    extends _$ThemeModeSettingCopyWithImpl<$Res, _$ThemeModeSettingImpl>
    implements _$$ThemeModeSettingImplCopyWith<$Res> {
  __$$ThemeModeSettingImplCopyWithImpl(
    _$ThemeModeSettingImpl _value,
    $Res Function(_$ThemeModeSettingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ThemeModeSetting
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? themeMode = null, Object? isSystemDarkMode = null}) {
    return _then(
      _$ThemeModeSettingImpl(
        themeMode: null == themeMode
            ? _value.themeMode
            : themeMode // ignore: cast_nullable_to_non_nullable
                  as AppThemeMode,
        isSystemDarkMode: null == isSystemDarkMode
            ? _value.isSystemDarkMode
            : isSystemDarkMode // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ThemeModeSettingImpl implements _ThemeModeSetting {
  const _$ThemeModeSettingImpl({
    this.themeMode = AppThemeMode.system,
    this.isSystemDarkMode = false,
  });

  factory _$ThemeModeSettingImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThemeModeSettingImplFromJson(json);

  @override
  @JsonKey()
  final AppThemeMode themeMode;
  @override
  @JsonKey()
  final bool isSystemDarkMode;

  @override
  String toString() {
    return 'ThemeModeSetting(themeMode: $themeMode, isSystemDarkMode: $isSystemDarkMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThemeModeSettingImpl &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.isSystemDarkMode, isSystemDarkMode) ||
                other.isSystemDarkMode == isSystemDarkMode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, themeMode, isSystemDarkMode);

  /// Create a copy of ThemeModeSetting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ThemeModeSettingImplCopyWith<_$ThemeModeSettingImpl> get copyWith =>
      __$$ThemeModeSettingImplCopyWithImpl<_$ThemeModeSettingImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ThemeModeSettingImplToJson(this);
  }
}

abstract class _ThemeModeSetting implements ThemeModeSetting {
  const factory _ThemeModeSetting({
    final AppThemeMode themeMode,
    final bool isSystemDarkMode,
  }) = _$ThemeModeSettingImpl;

  factory _ThemeModeSetting.fromJson(Map<String, dynamic> json) =
      _$ThemeModeSettingImpl.fromJson;

  @override
  AppThemeMode get themeMode;
  @override
  bool get isSystemDarkMode;

  /// Create a copy of ThemeModeSetting
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ThemeModeSettingImplCopyWith<_$ThemeModeSettingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
