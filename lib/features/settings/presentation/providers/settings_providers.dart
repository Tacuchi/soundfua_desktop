import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/theme_mode_setting.dart';
import '../../domain/usecases/get_theme_mode_setting.dart';
import '../../domain/usecases/save_theme_mode_setting.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/util/logger.dart';
import '../state/settings_state.dart';
import '../../../../core/di/injection.dart';

/// Settings notifier class that manages the settings state
class SettingsNotifier extends StateNotifier<SettingsState> {
  final GetThemeModeSetting _getThemeModeSetting;
  final SaveThemeModeSetting _saveThemeModeSetting;

  SettingsNotifier(this._getThemeModeSetting, this._saveThemeModeSetting)
    : super(const SettingsState()) {
    _loadThemeModeSetting();
  }

  /// Load theme mode setting
  Future<void> _loadThemeModeSetting() async {
    Logger().info('Loading theme mode setting', tag: 'SETTINGS');
    state = state.copyWith(isLoading: true, error: null);

    final result = await _getThemeModeSetting(const NoParams());

    result.fold(
      (failure) {
        Logger().error(
          'Failed to load theme mode setting',
          tag: 'SETTINGS',
          error: failure,
        );
        state = state.copyWith(
          isLoading: false,
          error: _mapFailureToMessage(failure),
        );
      },
      (themeModeSetting) {
        Logger().info(
          'Loaded theme mode setting: ${themeModeSetting.themeMode}',
          tag: 'SETTINGS',
        );
        state = state.copyWith(
          isLoading: false,
          themeModeSetting: themeModeSetting,
          error: null,
        );
      },
    );
  }

  /// Save theme mode setting
  Future<void> saveThemeMode(AppThemeMode themeMode) async {
    Logger().info('Saving theme mode: $themeMode', tag: 'SETTINGS');
    state = state.copyWith(isLoading: true, error: null);

    final result = await _saveThemeModeSetting(
      SaveThemeModeParams(themeMode: themeMode),
    );

    result.fold(
      (failure) {
        Logger().error(
          'Failed to save theme mode',
          tag: 'SETTINGS',
          error: failure,
        );
        state = state.copyWith(
          isLoading: false,
          error: _mapFailureToMessage(failure),
        );
      },
      (_) {
        Logger().info(
          'Successfully saved theme mode: $themeMode',
          tag: 'SETTINGS',
        );
        state = state.copyWith(
          isLoading: false,
          themeModeSetting: state.themeModeSetting.copyWith(
            themeMode: themeMode,
          ),
          error: null,
        );
      },
    );
  }

  /// Reload settings
  Future<void> reload() async {
    await _loadThemeModeSetting();
  }

  /// Map failure to user-friendly message
  String _mapFailureToMessage(failure) {
    return failure.when(
      serverFailure: (message) => 'Error del servidor: $message',
      cacheFailure: (message) => 'Error de configuración: $message',
      fileFailure: (message) => 'Error de archivo: $message',
      databaseFailure: (message) => 'Error de base de datos: $message',
      validationFailure: (message) => 'Error de validación: $message',
      unknownFailure: (message) => 'Error desconocido: $message',
    );
  }
}

/// Provider for the settings notifier
final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>(
  (ref) {
    return SettingsNotifier(
      ref.read(getThemeModeSettingProvider),
      ref.read(saveThemeModeSettingProvider),
    );
  },
);

/// Provider that exposes only the current theme mode for easy access
final currentThemeModeProvider = Provider<AppThemeMode>((ref) {
  return ref.watch(settingsProvider).themeModeSetting.themeMode;
});
