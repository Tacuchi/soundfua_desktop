import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/util/logger.dart';
import '../../models/theme_mode_setting_model.dart';

/// Abstract local data source for settings
abstract class SettingsLocalDataSource {
  /// Get theme mode setting from local storage
  Future<ThemeModeSettingModel> getThemeModeSetting();

  /// Save theme mode setting to local storage
  Future<void> saveThemeModeSetting(ThemeModeSettingModel themeModeSetting);

  /// Stream of theme mode changes
  Stream<ThemeModeSettingModel> get themeModeStream;
}

/// Implementation of settings local data source using SharedPreferences
class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  static const String _themeModeKey = 'theme_mode_setting';

  final SharedPreferences _prefs;
  final StreamController<ThemeModeSettingModel> _themeModeController =
      StreamController<ThemeModeSettingModel>.broadcast();

  SettingsLocalDataSourceImpl(this._prefs);

  @override
  Future<ThemeModeSettingModel> getThemeModeSetting() async {
    try {
      Logger().info(
        'Getting theme mode setting from local storage',
        tag: 'SETTINGS',
      );

      final jsonString = _prefs.getString(_themeModeKey);

      if (jsonString == null) {
        Logger().info(
          'No theme mode setting found, returning default',
          tag: 'SETTINGS',
        );
        return const ThemeModeSettingModel();
      }

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      final setting = ThemeModeSettingModel.fromJson(json);

      Logger().info(
        'Retrieved theme mode setting: ${setting.themeMode}',
        tag: 'SETTINGS',
      );
      return setting;
    } catch (e, stackTrace) {
      Logger().error(
        'Failed to get theme mode setting, returning default',
        tag: 'SETTINGS',
        error: e,
        stackTrace: stackTrace,
      );
      return const ThemeModeSettingModel();
    }
  }

  @override
  Future<void> saveThemeModeSetting(
    ThemeModeSettingModel themeModeSetting,
  ) async {
    try {
      Logger().info(
        'Saving theme mode setting: ${themeModeSetting.themeMode}',
        tag: 'SETTINGS',
      );

      final json = themeModeSetting.toJson();
      final jsonString = jsonEncode(json);

      await _prefs.setString(_themeModeKey, jsonString);

      Logger().info('Theme mode setting saved successfully', tag: 'SETTINGS');

      // Notify listeners
      _themeModeController.add(themeModeSetting);
    } catch (e, stackTrace) {
      Logger().error(
        'Failed to save theme mode setting',
        tag: 'SETTINGS',
        error: e,
        stackTrace: stackTrace,
      );
      throw Exception('Error al guardar configuración de tema: $e');
    }
  }

  @override
  Stream<ThemeModeSettingModel> get themeModeStream =>
      _themeModeController.stream;

  /// Clean up resources
  void dispose() {
    _themeModeController.close();
  }
}
