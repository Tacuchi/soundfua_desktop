import 'dart:async';
import 'dart:convert';
import '../../../../sound_library/data/datasources/local/app_database.dart';
import '../../../../../core/util/logger.dart';
import '../../models/theme_mode_setting_model.dart';
import '../../models/keyboard_shortcut_setting_model.dart';
import '../../models/volume_setting_model.dart';

/// Database data source for settings using SQLite
class SettingsDatabaseDataSource {
  final AppDatabase _database;

  // Stream controllers for reactive updates
  final StreamController<ThemeModeSettingModel> _themeModeController =
      StreamController<ThemeModeSettingModel>.broadcast();
  final StreamController<KeyboardShortcutSettingModel>
  _keyboardShortcutController =
      StreamController<KeyboardShortcutSettingModel>.broadcast();
  final StreamController<VolumeSettingModel> _volumeController =
      StreamController<VolumeSettingModel>.broadcast();

  SettingsDatabaseDataSource(this._database);

  // Setting keys
  static const String _themeModeKey = 'theme_mode_setting';
  static const String _keyboardShortcutKey = 'keyboard_shortcut_setting';
  static const String _volumeKey = 'volume_setting';

  // ====== THEME MODE SETTINGS ======

  /// Get theme mode setting from database
  Future<ThemeModeSettingModel> getThemeModeSetting() async {
    try {
      final jsonString = await _database.getSettingValue(_themeModeKey);

      if (jsonString != null) {
        final json = jsonDecode(jsonString) as Map<String, dynamic>;
        final setting = ThemeModeSettingModel.fromJson(json);
        Logger().debug(
          'Loaded theme mode from database: ${setting.themeMode}',
          tag: 'SETTINGS_DB',
        );
        return setting;
      }

      // Return default if not found
      const defaultSetting = ThemeModeSettingModel();
      Logger().info(
        'No theme mode found in database, using default',
        tag: 'SETTINGS_DB',
      );
      return defaultSetting;
    } catch (e, stackTrace) {
      Logger().error(
        'Failed to get theme mode from database',
        tag: 'SETTINGS_DB',
        error: e,
        stackTrace: stackTrace,
      );
      return const ThemeModeSettingModel();
    }
  }

  /// Save theme mode setting to database
  Future<void> saveThemeModeSetting(ThemeModeSettingModel setting) async {
    try {
      final jsonString = jsonEncode(setting.toJson());
      await _database.saveSetting(_themeModeKey, jsonString);

      Logger().info(
        'Saved theme mode to database: ${setting.themeMode}',
        tag: 'SETTINGS_DB',
      );

      // Notify listeners
      _themeModeController.add(setting);
    } catch (e, stackTrace) {
      Logger().error(
        'Failed to save theme mode to database',
        tag: 'SETTINGS_DB',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Stream of theme mode changes
  Stream<ThemeModeSettingModel> get themeModeStream =>
      _themeModeController.stream;

  // ====== KEYBOARD SHORTCUT SETTINGS ======

  /// Get keyboard shortcut setting from database
  Future<KeyboardShortcutSettingModel> getKeyboardShortcutSetting() async {
    try {
      final jsonString = await _database.getSettingValue(_keyboardShortcutKey);

      if (jsonString != null) {
        final json = jsonDecode(jsonString) as Map<String, dynamic>;
        final setting = KeyboardShortcutSettingModel.fromJson(json);
        Logger().debug(
          'Loaded keyboard shortcuts from database',
          tag: 'SETTINGS_DB',
        );
        return setting;
      }

      // Return default if not found
      const defaultSetting = KeyboardShortcutSettingModel();
      Logger().info(
        'No keyboard shortcuts found in database, using default',
        tag: 'SETTINGS_DB',
      );
      return defaultSetting;
    } catch (e, stackTrace) {
      Logger().error(
        'Failed to get keyboard shortcuts from database',
        tag: 'SETTINGS_DB',
        error: e,
        stackTrace: stackTrace,
      );
      return const KeyboardShortcutSettingModel();
    }
  }

  /// Save keyboard shortcut setting to database
  Future<void> saveKeyboardShortcutSetting(
    KeyboardShortcutSettingModel setting,
  ) async {
    try {
      final jsonString = jsonEncode(setting.toJson());
      await _database.saveSetting(_keyboardShortcutKey, jsonString);

      Logger().info('Saved keyboard shortcuts to database', tag: 'SETTINGS_DB');

      // Notify listeners
      _keyboardShortcutController.add(setting);
    } catch (e, stackTrace) {
      Logger().error(
        'Failed to save keyboard shortcuts to database',
        tag: 'SETTINGS_DB',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Stream of keyboard shortcut changes
  Stream<KeyboardShortcutSettingModel> get keyboardShortcutStream =>
      _keyboardShortcutController.stream;

  // ====== VOLUME SETTINGS ======

  /// Get volume setting from database
  Future<VolumeSettingModel> getVolumeSetting() async {
    try {
      final jsonString = await _database.getSettingValue(_volumeKey);

      if (jsonString != null) {
        final json = jsonDecode(jsonString) as Map<String, dynamic>;
        final setting = VolumeSettingModel.fromJson(json);
        Logger().debug(
          'Loaded volume settings from database: ${setting.volumeDescription}',
          tag: 'SETTINGS_DB',
        );
        return setting;
      }

      // Return default if not found
      const defaultSetting = VolumeSettingModel();
      Logger().info(
        'No volume settings found in database, using default',
        tag: 'SETTINGS_DB',
      );
      return defaultSetting;
    } catch (e, stackTrace) {
      Logger().error(
        'Failed to get volume settings from database',
        tag: 'SETTINGS_DB',
        error: e,
        stackTrace: stackTrace,
      );
      return const VolumeSettingModel();
    }
  }

  /// Save volume setting to database
  Future<void> saveVolumeSetting(VolumeSettingModel setting) async {
    try {
      final jsonString = jsonEncode(setting.toJson());
      await _database.saveSetting(_volumeKey, jsonString);

      Logger().info(
        'Saved volume settings to database: ${setting.volumeDescription}',
        tag: 'SETTINGS_DB',
      );

      // Notify listeners
      _volumeController.add(setting);
    } catch (e, stackTrace) {
      Logger().error(
        'Failed to save volume settings to database',
        tag: 'SETTINGS_DB',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Stream of volume changes
  Stream<VolumeSettingModel> get volumeStream => _volumeController.stream;

  // ====== MIGRATION FROM SHARED PREFERENCES ======

  /// Migrate settings from SharedPreferences to database
  /// This will be called during app initialization
  Future<void> migrateFromSharedPreferences(
    Map<String, String> prefsData,
  ) async {
    try {
      Logger().info(
        'Starting migration from SharedPreferences to database',
        tag: 'SETTINGS_DB',
      );

      // Check if migration is needed (settings don't exist in database)
      final existingSettings = await _database.getAllSettings();
      if (existingSettings.isNotEmpty) {
        Logger().info(
          'Settings already exist in database, skipping migration',
          tag: 'SETTINGS_DB',
        );
        return;
      }

      int migrated = 0;

      // Migrate theme mode if exists
      if (prefsData.containsKey('theme_mode_setting')) {
        await _database.saveSetting(
          _themeModeKey,
          prefsData['theme_mode_setting']!,
        );
        migrated++;
      }

      // Migrate keyboard shortcuts if exists
      if (prefsData.containsKey('keyboard_shortcut_setting')) {
        await _database.saveSetting(
          _keyboardShortcutKey,
          prefsData['keyboard_shortcut_setting']!,
        );
        migrated++;
      }

      // Migrate volume settings if exists
      if (prefsData.containsKey('volume_setting')) {
        await _database.saveSetting(_volumeKey, prefsData['volume_setting']!);
        migrated++;
      }

      Logger().info(
        'Migration completed: $migrated settings migrated',
        tag: 'SETTINGS_DB',
      );
    } catch (e, stackTrace) {
      Logger().error(
        'Failed to migrate settings from SharedPreferences',
        tag: 'SETTINGS_DB',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Clean up resources
  void dispose() {
    _themeModeController.close();
    _keyboardShortcutController.close();
    _volumeController.close();
  }
}
