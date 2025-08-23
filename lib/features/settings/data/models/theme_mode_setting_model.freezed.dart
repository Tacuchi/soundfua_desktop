// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_mode_setting_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ThemeModeSettingModel _$ThemeModeSettingModelFromJson(
  Map<String, dynamic> json,
) {
  return _ThemeModeSettingModel.fromJson(json);
}

/// @nodoc
mixin _$ThemeModeSettingModel {
  AppThemeMode get themeMode => throw _privateConstructorUsedError;
  bool get isSystemDarkMode => throw _privateConstructorUsedError;

  /// Serializes this ThemeModeSettingModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ThemeModeSettingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ThemeModeSettingModelCopyWith<ThemeModeSettingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemeModeSettingModelCopyWith<$Res> {
  factory $ThemeModeSettingModelCopyWith(
    ThemeModeSettingModel value,
    $Res Function(ThemeModeSettingModel) then,
  ) = _$ThemeModeSettingModelCopyWithImpl<$Res, ThemeModeSettingModel>;
  @useResult
  $Res call({AppThemeMode themeMode, bool isSystemDarkMode});
}

/// @nodoc
class _$ThemeModeSettingModelCopyWithImpl<
  $Res,
  $Val extends ThemeModeSettingModel
>
    implements $ThemeModeSettingModelCopyWith<$Res> {
  _$ThemeModeSettingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ThemeModeSettingModel
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
abstract class _$$ThemeModeSettingModelImplCopyWith<$Res>
    implements $ThemeModeSettingModelCopyWith<$Res> {
  factory _$$ThemeModeSettingModelImplCopyWith(
    _$ThemeModeSettingModelImpl value,
    $Res Function(_$ThemeModeSettingModelImpl) then,
  ) = __$$ThemeModeSettingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AppThemeMode themeMode, bool isSystemDarkMode});
}

/// @nodoc
class __$$ThemeModeSettingModelImplCopyWithImpl<$Res>
    extends
        _$ThemeModeSettingModelCopyWithImpl<$Res, _$ThemeModeSettingModelImpl>
    implements _$$ThemeModeSettingModelImplCopyWith<$Res> {
  __$$ThemeModeSettingModelImplCopyWithImpl(
    _$ThemeModeSettingModelImpl _value,
    $Res Function(_$ThemeModeSettingModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ThemeModeSettingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? themeMode = null, Object? isSystemDarkMode = null}) {
    return _then(
      _$ThemeModeSettingModelImpl(
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
class _$ThemeModeSettingModelImpl implements _ThemeModeSettingModel {
  const _$ThemeModeSettingModelImpl({
    this.themeMode = AppThemeMode.system,
    this.isSystemDarkMode = false,
  });

  factory _$ThemeModeSettingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThemeModeSettingModelImplFromJson(json);

  @override
  @JsonKey()
  final AppThemeMode themeMode;
  @override
  @JsonKey()
  final bool isSystemDarkMode;

  @override
  String toString() {
    return 'ThemeModeSettingModel(themeMode: $themeMode, isSystemDarkMode: $isSystemDarkMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThemeModeSettingModelImpl &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.isSystemDarkMode, isSystemDarkMode) ||
                other.isSystemDarkMode == isSystemDarkMode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, themeMode, isSystemDarkMode);

  /// Create a copy of ThemeModeSettingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ThemeModeSettingModelImplCopyWith<_$ThemeModeSettingModelImpl>
  get copyWith =>
      __$$ThemeModeSettingModelImplCopyWithImpl<_$ThemeModeSettingModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ThemeModeSettingModelImplToJson(this);
  }
}

abstract class _ThemeModeSettingModel implements ThemeModeSettingModel {
  const factory _ThemeModeSettingModel({
    final AppThemeMode themeMode,
    final bool isSystemDarkMode,
  }) = _$ThemeModeSettingModelImpl;

  factory _ThemeModeSettingModel.fromJson(Map<String, dynamic> json) =
      _$ThemeModeSettingModelImpl.fromJson;

  @override
  AppThemeMode get themeMode;
  @override
  bool get isSystemDarkMode;

  /// Create a copy of ThemeModeSettingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ThemeModeSettingModelImplCopyWith<_$ThemeModeSettingModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
