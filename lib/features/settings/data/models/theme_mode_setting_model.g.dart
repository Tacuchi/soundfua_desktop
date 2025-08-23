// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_mode_setting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ThemeModeSettingModelImpl _$$ThemeModeSettingModelImplFromJson(
  Map<String, dynamic> json,
) => _$ThemeModeSettingModelImpl(
  themeMode:
      $enumDecodeNullable(_$AppThemeModeEnumMap, json['themeMode']) ??
      AppThemeMode.system,
  isSystemDarkMode: json['isSystemDarkMode'] as bool? ?? false,
);

Map<String, dynamic> _$$ThemeModeSettingModelImplToJson(
  _$ThemeModeSettingModelImpl instance,
) => <String, dynamic>{
  'themeMode': _$AppThemeModeEnumMap[instance.themeMode]!,
  'isSystemDarkMode': instance.isSystemDarkMode,
};

const _$AppThemeModeEnumMap = {
  AppThemeMode.light: 'light',
  AppThemeMode.dark: 'dark',
  AppThemeMode.system: 'system',
};
