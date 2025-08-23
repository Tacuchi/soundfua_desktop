import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/theme_mode_setting.dart';

part 'settings_state.freezed.dart';

/// State for settings feature
@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(false) bool isLoading,
    @Default(ThemeModeSetting()) ThemeModeSetting themeModeSetting,
    String? error,
  }) = _SettingsState;
}
