// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_mode_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ThemeModeSettingImpl _$$ThemeModeSettingImplFromJson(
  Map<String, dynamic> json,
) => _$ThemeModeSettingImpl(
  themeMode:
      $enumDecodeNullable(_$AppThemeModeEnumMap, json['themeMode']) ??
      AppThemeMode.system,
  isSystemDarkMode: json['isSystemDarkMode'] as bool? ?? false,
);

Map<String, dynamic> _$$ThemeModeSettingImplToJson(
  _$ThemeModeSettingImpl instance,
) => <String, dynamic>{
  'themeMode': _$AppThemeModeEnumMap[instance.themeMode]!,
  'isSystemDarkMode': instance.isSystemDarkMode,
};

const _$AppThemeModeEnumMap = {
  AppThemeMode.light: 'light',
  AppThemeMode.dark: 'dark',
  AppThemeMode.system: 'system',
};
