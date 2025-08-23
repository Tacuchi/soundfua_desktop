import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/services/multi_audio_service.dart';
import '../../../../core/util/logger.dart';

/// Provider for the multi-audio service
final multiAudioServiceProvider = Provider<MultiAudioService>((ref) {
  Logger().audioInfo('Creating MultiAudioService provider');
  return MultiAudioService();
});

/// State class for multi-audio player
class MultiAudioPlayerState {
  final Map<String, AudioInstance> activeInstances;
  final String? lastPlayedFilePath;
  final String? mostRecentInstanceId;

  const MultiAudioPlayerState({
    this.activeInstances = const {},
    this.lastPlayedFilePath,
    this.mostRecentInstanceId,
  });

  MultiAudioPlayerState copyWith({
    Map<String, AudioInstance>? activeInstances,
    String? lastPlayedFilePath,
    String? mostRecentInstanceId,
  }) {
    return MultiAudioPlayerState(
      activeInstances: activeInstances ?? this.activeInstances,
      lastPlayedFilePath: lastPlayedFilePath ?? this.lastPlayedFilePath,
      mostRecentInstanceId: mostRecentInstanceId ?? this.mostRecentInstanceId,
    );
  }

  /// Get the most recent instance for a file
  AudioInstance? getMostRecentInstanceForFile(String filePath) {
    final instances = activeInstances.values
        .where((instance) => instance.filePath == filePath)
        .toList();

    if (instances.isEmpty) return null;

    // Sort by instance ID (which contains timestamp) to get most recent
    instances.sort((a, b) => b.id.compareTo(a.id));
    return instances.first;
  }

  /// Check if any instance of file is playing
  bool isFileCurrentlyPlaying(String filePath) {
    return activeInstances.values
        .where((instance) => instance.filePath == filePath)
        .any((instance) => instance.isPlaying);
  }

  /// Check if there are any active instances for file
  bool hasActiveInstancesForFile(String filePath) {
    return activeInstances.values.any(
      (instance) => instance.filePath == filePath,
    );
  }

  /// Get playing instances count for file
  int getPlayingInstancesCount(String filePath) {
    return activeInstances.values
        .where(
          (instance) => instance.filePath == filePath && instance.isPlaying,
        )
        .length;
  }

  /// Get total active instances count
  int get totalActiveInstancesCount => activeInstances.length;
}

/// Multi-audio player notifier
class MultiAudioPlayerNotifier extends StateNotifier<MultiAudioPlayerState> {
  final MultiAudioService _multiAudioService;

  MultiAudioPlayerNotifier(this._multiAudioService)
    : super(const MultiAudioPlayerState()) {
    Logger().audioInfo('Initializing MultiAudioPlayerNotifier');
    _initializeListeners();
  }

  void _initializeListeners() {
    // Listen to instances changes
    _multiAudioService.instancesStream.listen((instances) {
      Logger().audioDebug(
        'Active instances changed: ${instances.length} total',
      );
      state = state.copyWith(activeInstances: instances);
    });
  }

  /// Play audio file (creates new instance for overlapping)
  Future<String> playAudio(String filePath) async {
    try {
      Logger().audioInfo(
        'Request to play audio from notifier',
        filePath: filePath,
      );

      final instanceId = await _multiAudioService.playAudio(filePath);

      // Update state with most recent info
      state = state.copyWith(
        lastPlayedFilePath: filePath,
        mostRecentInstanceId: instanceId,
      );

      Logger().audioInfo(
        'Successfully started playback, instance: $instanceId',
        filePath: filePath,
      );
      return instanceId;
    } catch (e, stackTrace) {
      Logger().audioError(
        'Failed to play audio from notifier',
        filePath: filePath,
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Get specific instance
  AudioInstance? getInstance(String instanceId) {
    return _multiAudioService.getInstance(instanceId);
  }

  /// Get all instances for a specific file path
  List<AudioInstance> getInstancesForFile(String filePath) {
    return _multiAudioService.getInstancesForFile(filePath);
  }

  /// Get the most recent instance for a file path (for UI progress display)
  AudioInstance? getMostRecentInstanceForFile(String filePath) {
    return _multiAudioService.getMostRecentInstanceForFile(filePath);
  }

  /// Pause specific instance
  Future<void> pauseInstance(String instanceId) async {
    try {
      await _multiAudioService.pauseInstance(instanceId);
      Logger().audioInfo('Paused instance from notifier: $instanceId');
    } catch (e, stackTrace) {
      Logger().audioError(
        'Failed to pause instance: $instanceId',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Resume specific instance
  Future<void> resumeInstance(String instanceId) async {
    try {
      await _multiAudioService.resumeInstance(instanceId);
      Logger().audioInfo('Resumed instance from notifier: $instanceId');
    } catch (e, stackTrace) {
      Logger().audioError(
        'Failed to resume instance: $instanceId',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Stop specific instance
  Future<void> stopInstance(String instanceId) async {
    try {
      await _multiAudioService.stopInstance(instanceId);
      Logger().audioInfo('Stopped instance from notifier: $instanceId');
    } catch (e, stackTrace) {
      Logger().audioError(
        'Failed to stop instance: $instanceId',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Stop all instances for a specific file
  Future<void> stopAllInstancesForFile(String filePath) async {
    try {
      Logger().audioInfo('Stopping all instances for file', filePath: filePath);
      await _multiAudioService.stopAllInstancesForFile(filePath);
    } catch (e, stackTrace) {
      Logger().audioError(
        'Failed to stop all instances',
        filePath: filePath,
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Stop all instances
  Future<void> stopAllInstances() async {
    try {
      Logger().audioInfo('Stopping all active instances');
      await _multiAudioService.stopAllInstances();
    } catch (e, stackTrace) {
      Logger().audioError(
        'Failed to stop all instances',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Toggle play/pause for the most recent instance of a file
  /// If no instances exist, create a new one
  Future<void> togglePlayPauseForFile(String filePath) async {
    try {
      Logger().audioInfo('Toggle play/pause requested', filePath: filePath);

      final mostRecent = getMostRecentInstanceForFile(filePath);

      if (mostRecent == null) {
        // No instances, play new
        Logger().audioInfo(
          'No instances found, creating new playback',
          filePath: filePath,
        );
        await playAudio(filePath);
      } else if (mostRecent.isPlaying) {
        // Most recent is playing, pause it
        Logger().audioInfo('Pausing most recent instance', filePath: filePath);
        await pauseInstance(mostRecent.id);
      } else if (mostRecent.isPaused) {
        // Most recent is paused, resume it
        Logger().audioInfo('Resuming most recent instance', filePath: filePath);
        await resumeInstance(mostRecent.id);
      } else {
        // Most recent is stopped, play new
        Logger().audioInfo(
          'Most recent instance stopped, creating new playback',
          filePath: filePath,
        );
        await playAudio(filePath);
      }
    } catch (e, stackTrace) {
      Logger().audioError(
        'Failed to toggle play/pause',
        filePath: filePath,
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Check if any instance of file is currently playing
  bool isFileCurrentlyPlaying(String filePath) {
    return _multiAudioService.isFileCurrentlyPlaying(filePath);
  }

  /// Check if there are any active instances for file
  bool hasActiveInstancesForFile(String filePath) {
    return _multiAudioService.hasActiveInstancesForFile(filePath);
  }

  /// Get playing instances count for file
  int getPlayingInstancesCount(String filePath) {
    return _multiAudioService.getPlayingInstancesCount(filePath);
  }

  /// Get total active instances count
  int get totalActiveInstancesCount =>
      _multiAudioService.totalActiveInstancesCount;

  @override
  void dispose() {
    Logger().audioInfo('Disposing MultiAudioPlayerNotifier');
    _multiAudioService.dispose();
    super.dispose();
  }
}

/// Provider for the multi-audio player notifier
final multiAudioPlayerProvider =
    StateNotifierProvider<MultiAudioPlayerNotifier, MultiAudioPlayerState>((
      ref,
    ) {
      final multiAudioService = ref.read(multiAudioServiceProvider);
      return MultiAudioPlayerNotifier(multiAudioService);
    });
