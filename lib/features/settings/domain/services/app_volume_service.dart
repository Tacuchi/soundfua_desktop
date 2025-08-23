import 'dart:async';
import '../entities/volume_setting.dart';
import '../../../sound_library/domain/services/multi_audio_service.dart';
import '../../../../core/util/logger.dart';

/// Service to manage application-wide volume settings
class AppVolumeService {
  static final AppVolumeService _instance = AppVolumeService._internal();
  factory AppVolumeService() => _instance;
  AppVolumeService._internal() {
    Logger().info('AppVolumeService initialized', tag: 'APP_VOLUME');
  }

  final MultiAudioService _audioService = MultiAudioService();
  final StreamController<VolumeSetting> _volumeController =
      StreamController<VolumeSetting>.broadcast();

  VolumeSetting _currentSetting = const VolumeSetting();

  /// Stream of volume setting changes
  Stream<VolumeSetting> get volumeStream => _volumeController.stream;

  /// Current volume setting
  VolumeSetting get currentSetting => _currentSetting;

  /// Update volume setting and apply to audio service
  Future<void> updateVolumeSetting(VolumeSetting setting) async {
    try {
      _currentSetting = setting;

      Logger().info(
        'Updating app volume to: ${setting.volumeDescription}',
        tag: 'APP_VOLUME',
      );

      // Apply to audio service
      if (setting.isMuted) {
        await _audioService.setMuted(true);
      } else {
        await _audioService.setGlobalVolume(setting.masterVolume);
      }

      // Notify listeners
      _volumeController.add(setting);

      Logger().info(
        'App volume updated successfully: ${setting.volumeDescription}',
        tag: 'APP_VOLUME',
      );
    } catch (e, stackTrace) {
      Logger().error(
        'Failed to update app volume',
        tag: 'APP_VOLUME',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Set volume (0.0 to 1.0)
  Future<void> setVolume(double volume) async {
    final newSetting = _currentSetting.copyWith(
      masterVolume: volume,
      isMuted: false,
    );
    await updateVolumeSetting(newSetting);
  }

  /// Set mute state
  Future<void> setMuted(bool muted) async {
    final newSetting = _currentSetting.copyWith(isMuted: muted);
    await updateVolumeSetting(newSetting);
  }

  /// Toggle mute state
  Future<void> toggleMute() async {
    await setMuted(!_currentSetting.isMuted);
  }

  /// Initialize with saved setting
  Future<void> initialize(VolumeSetting savedSetting) async {
    Logger().info(
      'Initializing AppVolumeService with saved setting: ${savedSetting.volumeDescription}',
      tag: 'APP_VOLUME',
    );

    await updateVolumeSetting(savedSetting);
  }

  /// Dispose resources
  void dispose() {
    _volumeController.close();
    Logger().info('AppVolumeService disposed', tag: 'APP_VOLUME');
  }
}
