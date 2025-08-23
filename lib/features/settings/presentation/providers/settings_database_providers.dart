import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/theme_mode_setting.dart';
import '../../domain/entities/keyboard_shortcut_setting.dart';
import '../../domain/entities/volume_setting.dart';
import '../../../../core/util/logger.dart';
import '../../../../core/di/injection.dart';

// ====== INITIALIZATION PROVIDER ======

/// Provider to initialize settings and migrate from SharedPreferences
final settingsInitializerProvider = FutureProvider<void>((ref) async {
  final repository = ref.read(settingsRepositoryProvider);
  final result = await repository.initializeSettings();

  result.fold(
    (failure) {
      Logger().error(
        'Failed to initialize settings',
        tag: 'SETTINGS_INIT',
        error: failure,
      );
      throw Exception('Failed to initialize settings: $failure');
    },
    (_) {
      Logger().info('Settings initialized successfully', tag: 'SETTINGS_INIT');
    },
  );
});

// ====== THEME MODE PROVIDERS ======

/// Provider for theme mode setting
final themeModeSettingProvider =
    StateNotifierProvider<ThemeModeSettingNotifier, ThemeModeSetting>((ref) {
      return ThemeModeSettingNotifier(ref);
    });

class ThemeModeSettingNotifier extends StateNotifier<ThemeModeSetting> {
  final Ref _ref;

  ThemeModeSettingNotifier(this._ref) : super(const ThemeModeSetting()) {
    _loadSetting();
  }

  Future<void> _loadSetting() async {
    try {
      final repository = _ref.read(settingsRepositoryProvider);
      final result = await repository.getThemeModeSetting();

      result.fold(
        (failure) {
          Logger().error(
            'Failed to load theme mode setting',
            tag: 'THEME_PROVIDER',
            error: failure,
          );
        },
        (setting) {
          state = setting;
          Logger().debug(
            'Theme mode setting loaded: ${setting.themeMode}',
            tag: 'THEME_PROVIDER',
          );
        },
      );
    } catch (e) {
      Logger().error(
        'Error loading theme mode setting',
        tag: 'THEME_PROVIDER',
        error: e,
      );
    }
  }

  Future<void> updateThemeMode(AppThemeMode themeMode) async {
    try {
      final repository = _ref.read(settingsRepositoryProvider);
      final result = await repository.saveThemeModeSetting(themeMode);

      result.fold(
        (failure) {
          Logger().error(
            'Failed to save theme mode',
            tag: 'THEME_PROVIDER',
            error: failure,
          );
        },
        (_) {
          state = state.copyWith(themeMode: themeMode);
          Logger().info(
            'Theme mode updated: $themeMode',
            tag: 'THEME_PROVIDER',
          );
        },
      );
    } catch (e) {
      Logger().error(
        'Error updating theme mode',
        tag: 'THEME_PROVIDER',
        error: e,
      );
    }
  }
}

// ====== KEYBOARD SHORTCUT PROVIDERS ======

/// Provider for keyboard shortcut setting
final keyboardShortcutSettingProvider =
    StateNotifierProvider<
      KeyboardShortcutSettingNotifier,
      KeyboardShortcutSetting
    >((ref) {
      return KeyboardShortcutSettingNotifier(ref);
    });

class KeyboardShortcutSettingNotifier
    extends StateNotifier<KeyboardShortcutSetting> {
  final Ref _ref;

  KeyboardShortcutSettingNotifier(this._ref)
    : super(const KeyboardShortcutSetting()) {
    _loadSetting();
  }

  Future<void> _loadSetting() async {
    try {
      final repository = _ref.read(settingsRepositoryProvider);
      final result = await repository.getKeyboardShortcutSetting();

      result.fold(
        (failure) {
          Logger().error(
            'Failed to load keyboard shortcut setting',
            tag: 'KEYBOARD_PROVIDER',
            error: failure,
          );
        },
        (setting) {
          state = setting;
          Logger().debug(
            'Keyboard shortcut setting loaded',
            tag: 'KEYBOARD_PROVIDER',
          );
        },
      );
    } catch (e) {
      Logger().error(
        'Error loading keyboard shortcut setting',
        tag: 'KEYBOARD_PROVIDER',
        error: e,
      );
    }
  }

  Future<void> updateQuickSoundsShortcut(String shortcut) async {
    try {
      final updatedSetting = state.copyWith(quickSoundsShortcut: shortcut);
      final repository = _ref.read(settingsRepositoryProvider);
      final result = await repository.saveKeyboardShortcutSetting(
        updatedSetting,
      );

      result.fold(
        (failure) {
          Logger().error(
            'Failed to save keyboard shortcut',
            tag: 'KEYBOARD_PROVIDER',
            error: failure,
          );
        },
        (_) {
          state = updatedSetting;
          Logger().info(
            'Keyboard shortcut updated: $shortcut',
            tag: 'KEYBOARD_PROVIDER',
          );
        },
      );
    } catch (e) {
      Logger().error(
        'Error updating keyboard shortcut',
        tag: 'KEYBOARD_PROVIDER',
        error: e,
      );
    }
  }
}

// ====== VOLUME PROVIDERS ======

/// Provider for volume setting
final volumeSettingDatabaseProvider =
    StateNotifierProvider<VolumeSettingNotifier, VolumeSetting>((ref) {
      return VolumeSettingNotifier(ref);
    });

class VolumeSettingNotifier extends StateNotifier<VolumeSetting> {
  final Ref _ref;

  VolumeSettingNotifier(this._ref) : super(const VolumeSetting()) {
    _loadSetting();
  }

  Future<void> _loadSetting() async {
    try {
      final repository = _ref.read(settingsRepositoryProvider);
      final result = await repository.getVolumeSetting();

      result.fold(
        (failure) {
          Logger().error(
            'Failed to load volume setting',
            tag: 'VOLUME_PROVIDER',
            error: failure,
          );
        },
        (setting) {
          state = setting;
          Logger().debug(
            'Volume setting loaded: ${setting.volumeDescription}',
            tag: 'VOLUME_PROVIDER',
          );
        },
      );
    } catch (e) {
      Logger().error(
        'Error loading volume setting',
        tag: 'VOLUME_PROVIDER',
        error: e,
      );
    }
  }

  Future<void> setVolume(double volume) async {
    try {
      final updatedSetting = state.copyWith(
        masterVolume: volume,
        isMuted: false,
      );
      final repository = _ref.read(settingsRepositoryProvider);
      final result = await repository.saveVolumeSetting(updatedSetting);

      result.fold(
        (failure) {
          Logger().error(
            'Failed to save volume setting',
            tag: 'VOLUME_PROVIDER',
            error: failure,
          );
        },
        (_) {
          state = updatedSetting;
          Logger().debug(
            'Volume updated: ${updatedSetting.volumeDescription}',
            tag: 'VOLUME_PROVIDER',
          );
        },
      );
    } catch (e) {
      Logger().error('Error updating volume', tag: 'VOLUME_PROVIDER', error: e);
    }
  }

  Future<void> toggleMute() async {
    try {
      final updatedSetting = state.copyWith(isMuted: !state.isMuted);
      final repository = _ref.read(settingsRepositoryProvider);
      final result = await repository.saveVolumeSetting(updatedSetting);

      result.fold(
        (failure) {
          Logger().error(
            'Failed to save mute setting',
            tag: 'VOLUME_PROVIDER',
            error: failure,
          );
        },
        (_) {
          state = updatedSetting;
          Logger().debug(
            'Mute toggled: ${updatedSetting.isMuted}',
            tag: 'VOLUME_PROVIDER',
          );
        },
      );
    } catch (e) {
      Logger().error('Error toggling mute', tag: 'VOLUME_PROVIDER', error: e);
    }
  }
}

// ====== CONVENIENCE PROVIDERS ======

/// Provider that exposes only the current theme mode for easy access
final currentThemeModeProvider = Provider<AppThemeMode>((ref) {
  return ref.watch(themeModeSettingProvider).themeMode;
});

/// Provider that exposes only the current keyboard shortcuts for easy access
final currentKeyboardShortcutsProvider = Provider<KeyboardShortcutSetting>((
  ref,
) {
  return ref.watch(keyboardShortcutSettingProvider);
});

/// Provider that exposes only the current volume setting for easy access
final currentVolumeProvider = Provider<VolumeSetting>((ref) {
  return ref.watch(volumeSettingDatabaseProvider);
});
