import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'theme_mode_setting.freezed.dart';
part 'theme_mode_setting.g.dart';

/// Enum for theme mode options
enum AppThemeMode {
  @JsonValue('light')
  light,
  @JsonValue('dark')
  dark,
  @JsonValue('system')
  system,
}

/// Extension to convert AppThemeMode to Flutter ThemeMode
extension AppThemeModeExtension on AppThemeMode {
  ThemeMode get toThemeMode {
    switch (this) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  String get displayName {
    switch (this) {
      case AppThemeMode.light:
        return 'Claro';
      case AppThemeMode.dark:
        return 'Oscuro';
      case AppThemeMode.system:
        return 'Sistema';
    }
  }

  IconData get icon {
    switch (this) {
      case AppThemeMode.light:
        return Icons.light_mode;
      case AppThemeMode.dark:
        return Icons.dark_mode;
      case AppThemeMode.system:
        return Icons.brightness_auto;
    }
  }
}

/// Theme mode setting entity
@freezed
class ThemeModeSetting with _$ThemeModeSetting {
  const factory ThemeModeSetting({
    @Default(AppThemeMode.system) AppThemeMode themeMode,
    @Default(false) bool isSystemDarkMode,
  }) = _ThemeModeSetting;

  factory ThemeModeSetting.fromJson(Map<String, dynamic> json) =>
      _$ThemeModeSettingFromJson(json);
}
