import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/theme_mode_setting.dart';
import '../entities/keyboard_shortcut_setting.dart';
import '../entities/volume_setting.dart';

/// Abstract settings repository
abstract class SettingsRepository {
  /// Get current theme mode setting
  Future<Either<Failure, ThemeModeSetting>> getThemeModeSetting();

  /// Save theme mode setting
  Future<Either<Failure, Unit>> saveThemeModeSetting(AppThemeMode themeMode);

  /// Stream of theme mode changes
  Stream<ThemeModeSetting> get themeModeStream;

  /// Get current keyboard shortcut setting
  Future<Either<Failure, KeyboardShortcutSetting>> getKeyboardShortcutSetting();

  /// Save keyboard shortcut setting
  Future<Either<Failure, Unit>> saveKeyboardShortcutSetting(
    KeyboardShortcutSetting setting,
  );

  /// Stream of keyboard shortcut changes
  Stream<KeyboardShortcutSetting> get keyboardShortcutStream;

  /// Get current volume setting
  Future<Either<Failure, VolumeSetting>> getVolumeSetting();

  /// Save volume setting
  Future<Either<Failure, Unit>> saveVolumeSetting(VolumeSetting setting);

  /// Stream of volume changes
  Stream<VolumeSetting> get volumeStream;

  /// Initialize and migrate from SharedPreferences if needed
  Future<Either<Failure, Unit>> initializeSettings();
}
