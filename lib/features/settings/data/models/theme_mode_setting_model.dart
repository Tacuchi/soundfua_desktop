import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/theme_mode_setting.dart';

part 'theme_mode_setting_model.freezed.dart';
part 'theme_mode_setting_model.g.dart';

/// Model for theme mode setting that extends the domain entity
@freezed
class ThemeModeSettingModel with _$ThemeModeSettingModel {
  const factory ThemeModeSettingModel({
    @Default(AppThemeMode.system) AppThemeMode themeMode,
    @Default(false) bool isSystemDarkMode,
  }) = _ThemeModeSettingModel;

  factory ThemeModeSettingModel.fromJson(Map<String, dynamic> json) =>
      _$ThemeModeSettingModelFromJson(json);

  /// Convert from domain entity to model
  factory ThemeModeSettingModel.fromEntity(ThemeModeSetting entity) {
    return ThemeModeSettingModel(
      themeMode: entity.themeMode,
      isSystemDarkMode: entity.isSystemDarkMode,
    );
  }
}

/// Extension to convert model to domain entity
extension ThemeModeSettingModelExtension on ThemeModeSettingModel {
  ThemeModeSetting toEntity() {
    return ThemeModeSetting(
      themeMode: themeMode,
      isSystemDarkMode: isSystemDarkMode,
    );
  }
}
