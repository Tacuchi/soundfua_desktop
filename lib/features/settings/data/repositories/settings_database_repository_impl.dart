import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/util/logger.dart';
import '../../domain/entities/theme_mode_setting.dart';
import '../../domain/entities/keyboard_shortcut_setting.dart';
import '../../domain/entities/volume_setting.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/local/settings_database_data_source.dart';
import '../models/theme_mode_setting_model.dart';
import '../models/keyboard_shortcut_setting_model.dart';
import '../models/volume_setting_model.dart';

/// Implementation of settings repository using SQLite database
class SettingsDatabaseRepositoryImpl implements SettingsRepository {
  final SettingsDatabaseDataSource _databaseDataSource;
  final SharedPreferences _sharedPreferences;

  SettingsDatabaseRepositoryImpl({
    required SettingsDatabaseDataSource databaseDataSource,
    required SharedPreferences sharedPreferences,
  }) : _databaseDataSource = databaseDataSource,
       _sharedPreferences = sharedPreferences;

  // ====== INITIALIZATION AND MIGRATION ======

  @override
  Future<Either<Failure, Unit>> initializeSettings() async {
    try {
      Logger().info('Initializing settings repository', tag: 'SETTINGS_REPO');

      // Get all SharedPreferences data for migration
      final prefsKeys = _sharedPreferences.getKeys();
      final prefsData = <String, String>{};

      for (final key in prefsKeys) {
        final value = _sharedPreferences.getString(key);
        if (value != null) {
          prefsData[key] = value;
        }
      }

      // Migrate from SharedPreferences to database if needed
      await _databaseDataSource.migrateFromSharedPreferences(prefsData);

      Logger().info(
        'Settings repository initialized successfully',
        tag: 'SETTINGS_REPO',
      );
      return const Right(unit);
    } catch (e, stackTrace) {
      Logger().error(
        'Failed to initialize settings repository',
        tag: 'SETTINGS_REPO',
        error: e,
        stackTrace: stackTrace,
      );
      return Left(CacheFailure('Error al inicializar configuraciones: $e'));
    }
  }

  // ====== THEME MODE SETTINGS ======

  @override
  Future<Either<Failure, ThemeModeSetting>> getThemeModeSetting() async {
    try {
      Logger().debug(
        'Getting theme mode setting from database',
        tag: 'SETTINGS_REPO',
      );

      final themeModeSetting = await _databaseDataSource.getThemeModeSetting();

      Logger().debug(
        'Retrieved theme mode setting: ${themeModeSetting.themeMode}',
        tag: 'SETTINGS_REPO',
      );
      return Right(themeModeSetting.toEntity());
    } catch (e, stackTrace) {
      Logger().error(
        'Failed to get theme mode setting',
        tag: 'SETTINGS_REPO',
        error: e,
        stackTrace: stackTrace,
      );
      return Left(CacheFailure('Error al obtener configuración de tema: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveThemeModeSetting(
    AppThemeMode themeMode,
  ) async {
    try {
      Logger().info(
        'Saving theme mode setting: $themeMode',
        tag: 'SETTINGS_REPO',
      );

      final themeModeSetting = ThemeModeSettingModel(themeMode: themeMode);
      await _databaseDataSource.saveThemeModeSetting(themeModeSetting);

      Logger().info(
        'Theme mode setting saved successfully',
        tag: 'SETTINGS_REPO',
      );
      return const Right(unit);
    } catch (e, stackTrace) {
      Logger().error(
        'Failed to save theme mode setting',
        tag: 'SETTINGS_REPO',
        error: e,
        stackTrace: stackTrace,
      );
      return Left(CacheFailure('Error al guardar configuración de tema: $e'));
    }
  }

  @override
  Stream<ThemeModeSetting> get themeModeStream {
    return _databaseDataSource.themeModeStream.map((model) => model.toEntity());
  }

  // ====== KEYBOARD SHORTCUT SETTINGS ======

  @override
  Future<Either<Failure, KeyboardShortcutSetting>>
  getKeyboardShortcutSetting() async {
    try {
      Logger().debug(
        'Getting keyboard shortcut setting from database',
        tag: 'SETTINGS_REPO',
      );

      final keyboardShortcutSetting = await _databaseDataSource
          .getKeyboardShortcutSetting();

      Logger().debug(
        'Retrieved keyboard shortcut setting',
        tag: 'SETTINGS_REPO',
      );
      return Right(keyboardShortcutSetting.toEntity());
    } catch (e, stackTrace) {
      Logger().error(
        'Failed to get keyboard shortcut setting',
        tag: 'SETTINGS_REPO',
        error: e,
        stackTrace: stackTrace,
      );
      return Left(CacheFailure('Error al obtener configuración de atajos: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveKeyboardShortcutSetting(
    KeyboardShortcutSetting setting,
  ) async {
    try {
      Logger().info('Saving keyboard shortcut setting', tag: 'SETTINGS_REPO');

      final keyboardShortcutSetting = KeyboardShortcutSettingModel.fromEntity(
        setting,
      );
      await _databaseDataSource.saveKeyboardShortcutSetting(
        keyboardShortcutSetting,
      );

      Logger().info(
        'Keyboard shortcut setting saved successfully',
        tag: 'SETTINGS_REPO',
      );
      return const Right(unit);
    } catch (e, stackTrace) {
      Logger().error(
        'Failed to save keyboard shortcut setting',
        tag: 'SETTINGS_REPO',
        error: e,
        stackTrace: stackTrace,
      );
      return Left(CacheFailure('Error al guardar configuración de atajos: $e'));
    }
  }

  @override
  Stream<KeyboardShortcutSetting> get keyboardShortcutStream {
    return _databaseDataSource.keyboardShortcutStream.map(
      (model) => model.toEntity(),
    );
  }

  // ====== VOLUME SETTINGS ======

  @override
  Future<Either<Failure, VolumeSetting>> getVolumeSetting() async {
    try {
      Logger().debug(
        'Getting volume setting from database',
        tag: 'SETTINGS_REPO',
      );

      final volumeSetting = await _databaseDataSource.getVolumeSetting();

      Logger().debug(
        'Retrieved volume setting: ${volumeSetting.volumeDescription}',
        tag: 'SETTINGS_REPO',
      );
      return Right(volumeSetting.toEntity());
    } catch (e, stackTrace) {
      Logger().error(
        'Failed to get volume setting',
        tag: 'SETTINGS_REPO',
        error: e,
        stackTrace: stackTrace,
      );
      return Left(
        CacheFailure('Error al obtener configuración de volumen: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> saveVolumeSetting(VolumeSetting setting) async {
    try {
      Logger().info(
        'Saving volume setting: ${setting.volumeDescription}',
        tag: 'SETTINGS_REPO',
      );

      final volumeSetting = VolumeSettingModel.fromEntity(setting);
      await _databaseDataSource.saveVolumeSetting(volumeSetting);

      Logger().info('Volume setting saved successfully', tag: 'SETTINGS_REPO');
      return const Right(unit);
    } catch (e, stackTrace) {
      Logger().error(
        'Failed to save volume setting',
        tag: 'SETTINGS_REPO',
        error: e,
        stackTrace: stackTrace,
      );
      return Left(
        CacheFailure('Error al guardar configuración de volumen: $e'),
      );
    }
  }

  @override
  Stream<VolumeSetting> get volumeStream {
    return _databaseDataSource.volumeStream.map((model) => model.toEntity());
  }
}
