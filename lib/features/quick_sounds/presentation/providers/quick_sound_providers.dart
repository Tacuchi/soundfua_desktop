import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/util/logger.dart';
import '../../../sound_library/domain/entities/sound.dart';
import '../../../sound_library/presentation/providers/sound_providers.dart';
import '../../../sound_library/presentation/state/sound_state.dart';
import '../../../settings/domain/entities/keyboard_shortcut_setting.dart';
import '../../../settings/presentation/providers/settings_database_providers.dart';
import '../../domain/services/quick_sound_service.dart';

/// Provider for QuickSoundService singleton
final quickSoundServiceProvider = Provider<QuickSoundService>((ref) {
  return QuickSoundService();
});

// Note: keyboard shortcut settings are now handled by the database providers
// in lib/features/settings/presentation/providers/settings_database_providers.dart

/// Provider that automatically initializes the quick sound service when settings change
final quickSoundInitializerProvider = Provider<void>((ref) {
  final quickSoundService = ref.watch(quickSoundServiceProvider);

  Logger().info('QuickSoundInitializerProvider called', tag: 'QUICK_SOUNDS');

  // Watch the settings database to ensure it's initialized first
  ref.watch(settingsInitializerProvider);

  // Initialize service with current settings from the database
  ref.listen<KeyboardShortcutSetting>(keyboardShortcutSettingProvider, (
    previous,
    next,
  ) {
    Logger().info(
      'KeyboardShortcutSetting listener triggered - previous: $previous, next: $next',
      tag: 'QUICK_SOUNDS',
    );
    if (previous != next) {
      Logger().info(
        'Keyboard shortcut settings changed, reinitializing service',
        tag: 'QUICK_SOUNDS',
      );
      quickSoundService.initialize(next);
    } else {
      // Initialize even if it's the first time (previous == null)
      Logger().info(
        'First time initialization with shortcut: ${next.quickSoundsShortcut}',
        tag: 'QUICK_SOUNDS',
      );
      quickSoundService.initialize(next);
    }
  }, fireImmediately: true);

  // Update sounds when they change
  ref.listen<SoundsState>(soundsProvider, (previous, next) {
    Logger().info(
      'SoundsState listener triggered - sounds count: ${next.sounds.length}',
      tag: 'QUICK_SOUNDS',
    );
    if (next.sounds.isNotEmpty) {
      Logger().info(
        'Sounds updated, updating quick sound service',
        tag: 'QUICK_SOUNDS',
      );
      quickSoundService.updateSounds(next.sounds);
    }
  }, fireImmediately: true);

  return;
});

/// Provider for overlay visibility state
final quickSoundOverlayVisibilityProvider = StreamProvider<bool>((ref) {
  final quickSoundService = ref.watch(quickSoundServiceProvider);
  return quickSoundService.visibilityStream;
});

/// Provider for selected sound index
final quickSoundSelectedIndexProvider = StreamProvider<int>((ref) {
  final quickSoundService = ref.watch(quickSoundServiceProvider);
  return quickSoundService.selectedIndexStream;
});

/// Provider for current sounds in quick overlay
final quickSoundCurrentSoundsProvider = StreamProvider<List<Sound>>((ref) {
  final quickSoundService = ref.watch(quickSoundServiceProvider);
  return quickSoundService.soundsStream;
});
