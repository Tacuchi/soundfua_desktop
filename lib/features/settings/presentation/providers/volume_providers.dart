import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/util/logger.dart';
import '../../domain/entities/volume_setting.dart';
import '../../domain/services/app_volume_service.dart';
import './settings_database_providers.dart';

/// Enhanced volume service that integrates with database persistence
class EnhancedAppVolumeService {
  final Ref _ref;
  final AppVolumeService _audioService;

  EnhancedAppVolumeService(this._ref) : _audioService = AppVolumeService();

  /// Initialize the service with database volume setting
  void initialize() {
    Logger().info(
      'EnhancedAppVolumeService initialized',
      tag: 'ENHANCED_VOLUME',
    );

    // Listen to volume setting changes from database
    _ref.listen(volumeSettingDatabaseProvider, (previous, next) {
      if (previous != next) {
        _syncVolumeToAudioService(next);
      }
    });

    // Set initial volume from database
    final volumeSetting = _ref.read(volumeSettingDatabaseProvider);
    _syncVolumeToAudioService(volumeSetting);
  }

  /// Sync volume setting to the audio service
  Future<void> _syncVolumeToAudioService(VolumeSetting setting) async {
    try {
      Logger().debug(
        'Syncing volume to audio service: ${setting.volumeDescription}',
        tag: 'ENHANCED_VOLUME',
      );

      // Initialize the audio service with the database values
      await _audioService.initialize(setting);
    } catch (e) {
      Logger().error(
        'Failed to sync volume to audio service',
        tag: 'ENHANCED_VOLUME',
        error: e,
      );
    }
  }

  /// Set volume and persist to database
  Future<void> setVolume(double volume) async {
    Logger().info(
      'Setting volume: ${(volume * 100).round()}%',
      tag: 'ENHANCED_VOLUME',
    );

    // Update database first
    await _ref.read(volumeSettingDatabaseProvider.notifier).setVolume(volume);

    // Audio service will be updated via listener
  }

  /// Toggle mute and persist to database
  Future<void> toggleMute() async {
    final currentMuteState = _ref.read(volumeSettingDatabaseProvider).isMuted;
    Logger().info(
      'Toggling mute to: ${!currentMuteState}',
      tag: 'ENHANCED_VOLUME',
    );

    // Update database first
    await _ref.read(volumeSettingDatabaseProvider.notifier).toggleMute();

    // Audio service will be updated via listener
  }
}

/// Updated notifier that uses database persistence
class VolumeSettingNotifier extends StateNotifier<VolumeSetting> {
  final EnhancedAppVolumeService _volumeService;

  VolumeSettingNotifier(this._volumeService) : super(const VolumeSetting());

  Future<void> setVolume(double volume) async {
    await _volumeService.setVolume(volume);
  }

  Future<void> toggleMute() async {
    await _volumeService.toggleMute();
  }
}

/// Provider for the enhanced volume service
final enhancedAppVolumeServiceProvider = Provider<EnhancedAppVolumeService>((
  ref,
) {
  return EnhancedAppVolumeService(ref);
});

/// Updated volume setting provider that delegates to database provider
final volumeSettingProvider = Provider<VolumeSetting>((ref) {
  return ref.watch(volumeSettingDatabaseProvider);
});

/// Notifier provider that uses the enhanced service
final volumeSettingNotifierProvider =
    StateNotifierProvider<VolumeSettingNotifier, VolumeSetting>((ref) {
      final enhancedService = ref.watch(enhancedAppVolumeServiceProvider);
      return VolumeSettingNotifier(enhancedService);
    });

/// Provider to ensure volume service is initialized
final volumeInitializerProvider = Provider<void>((ref) {
  final enhancedService = ref.watch(enhancedAppVolumeServiceProvider);
  enhancedService.initialize();
  Logger().info('VolumeInitializerProvider called', tag: 'VOLUME_PROVIDER');
  return;
});
