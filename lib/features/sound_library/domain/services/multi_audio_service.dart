import 'package:dart_vlc/dart_vlc.dart';
import 'dart:async';
import 'dart:io';
import '../../../../core/util/logger.dart';
import '../../../settings/domain/entities/audio_device.dart';

/// Individual audio instance for managing a single audio playback with dart_vlc
class AudioInstance {
  final String id;
  final String filePath;
  final Player player;
  final StreamController<PositionState> _positionController =
      StreamController<PositionState>.broadcast();
  final StreamController<PlaybackState> _stateController =
      StreamController<PlaybackState>.broadcast();

  bool _isDisposed = false;
  PlaybackState _currentState = PlaybackState();
  PositionState _currentPosition = PositionState();

  AudioInstance({required this.id, required this.filePath, required int playerId})
      : player = Player(
          id: playerId,
          commandlineArguments: ['--no-video'], // Audio-only mode
        ) {
    Logger().audioInfo('Creating new audio instance', filePath: filePath);
    _initializeListeners();
  }

  void _initializeListeners() {
    // Position listener
    player.positionStream.listen((position) {
      if (!_isDisposed) {
        _currentPosition = position;
        _positionController.add(position);
        Logger().audioDebug(
          'Position changed: ${position.position?.inMilliseconds ?? 0}ms',
          filePath: filePath,
        );
      }
    });

    // State listener
    player.playbackStream.listen((state) {
      if (!_isDisposed) {
        _currentState = state;
        _stateController.add(state);
        Logger().audioInfo(
          'State changed: isPlaying=${state.isPlaying}, isCompleted=${state.isCompleted}',
          filePath: filePath,
        );

        // Clean up when playback completes
        if (state.isCompleted) {
          Logger().audioInfo(
            'Playback completed, scheduling cleanup',
            filePath: filePath,
          );
          Timer(const Duration(seconds: 1), () {
            if (!_isDisposed) {
              dispose();
            }
          });
        }
      }
    });
  }

  /// Start playing audio
  Future<void> play() async {
    try {
      Logger().audioInfo('Starting playback', filePath: filePath);
      final media = Media.file(File(filePath));
      player.open(media, autoStart: true);
      Logger().audioInfo('Playback started successfully', filePath: filePath);
    } catch (e, stackTrace) {
      Logger().audioError(
        'Failed to start playback',
        filePath: filePath,
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Pause audio
  Future<void> pause() async {
    try {
      Logger().audioInfo('Pausing playback', filePath: filePath);
      player.pause();
    } catch (e, stackTrace) {
      Logger().audioError(
        'Failed to pause playback',
        filePath: filePath,
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Resume audio
  Future<void> resume() async {
    try {
      Logger().audioInfo('Resuming playback', filePath: filePath);
      player.play();
    } catch (e, stackTrace) {
      Logger().audioError(
        'Failed to resume playback',
        filePath: filePath,
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Stop audio
  Future<void> stop() async {
    try {
      Logger().audioInfo('Stopping playback', filePath: filePath);
      player.stop();
    } catch (e, stackTrace) {
      Logger().audioError(
        'Failed to stop playback',
        filePath: filePath,
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Seek to position
  Future<void> seek(Duration position) async {
    try {
      Logger().audioDebug(
        'Seeking to position: ${position.inMilliseconds}ms',
        filePath: filePath,
      );
      player.seek(position);
    } catch (e, stackTrace) {
      Logger().audioError(
        'Failed to seek',
        filePath: filePath,
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Set audio device for this player
  void setDevice(AudioDevice device) {
    try {
      final vlcDevices = Devices.all;
      final vlcDevice = vlcDevices.firstWhere(
        (d) => d.id == device.id,
        orElse: () => vlcDevices.first,
      );
      player.setDevice(vlcDevice);
      Logger().audioInfo(
        'Device set to ${device.name} for instance',
        filePath: filePath,
      );
    } catch (e) {
      Logger().audioError(
        'Failed to set device for instance',
        filePath: filePath,
        error: e,
      );
    }
  }

  /// Get current position
  Duration get currentPosition => _currentPosition.position ?? Duration.zero;

  /// Get total duration
  Duration get totalDuration => _currentPosition.duration ?? Duration.zero;

  /// Get current state
  PlaybackState get currentState => _currentState;

  /// Position stream
  Stream<PositionState> get positionStream => _positionController.stream;

  /// State stream
  Stream<PlaybackState> get stateStream => _stateController.stream;

  /// Check if currently playing
  bool get isPlaying => _currentState.isPlaying;

  /// Check if paused
  bool get isPaused => !_currentState.isPlaying && currentPosition > Duration.zero;

  /// Check if stopped
  bool get isStopped => !_currentState.isPlaying && currentPosition == Duration.zero;

  /// Dispose resources
  void dispose() {
    if (_isDisposed) return;

    Logger().audioInfo('Disposing audio instance', filePath: filePath);
    _isDisposed = true;

    try {
      player.dispose();
      _positionController.close();
      _stateController.close();
    } catch (e, stackTrace) {
      Logger().audioError(
        'Error during disposal',
        filePath: filePath,
        error: e,
        stackTrace: stackTrace,
      );
    }
  }
}

/// Enhanced audio service supporting multiple concurrent playbacks with dart_vlc
class MultiAudioService {
  static final MultiAudioService _instance = MultiAudioService._internal();
  factory MultiAudioService() => _instance;
  MultiAudioService._internal() {
    Logger().audioInfo('MultiAudioService initialized with dart_vlc');
  }

  final Map<String, AudioInstance> _activeInstances = {};
  final StreamController<Map<String, AudioInstance>> _instancesController =
      StreamController<Map<String, AudioInstance>>.broadcast();

  // Global volume control
  double _globalVolume = 0.7; // Default volume (70%)
  bool _isMuted = false;
  AudioDevice? _currentDevice;

  // Player ID counter for unique player instances
  int _nextPlayerId = 100; // Start from 100 to avoid conflicts

  /// Get all active instances
  Map<String, AudioInstance> get activeInstances =>
      Map.unmodifiable(_activeInstances);

  /// Stream of active instances changes
  Stream<Map<String, AudioInstance>> get instancesStream =>
      _instancesController.stream;

  /// Get current global volume
  double get globalVolume => _globalVolume;

  /// Get current mute state
  bool get isMuted => _isMuted;

  /// Get current audio device
  AudioDevice? get currentDevice => _currentDevice;

  /// Set audio device for all players
  Future<void> setDevice(AudioDevice? device) async {
    if (device == null) return;

    _currentDevice = device;
    Logger().audioInfo(
      'Setting global device to: ${device.name}',
    );

    // Apply device to all active instances
    for (final instance in _activeInstances.values) {
      try {
        instance.setDevice(device);
      } catch (e) {
        Logger().audioError(
          'Failed to set device for instance ${instance.id}',
          error: e,
        );
      }
    }
  }

  /// Set global volume (0.0 to 1.0)
  Future<void> setGlobalVolume(double volume) async {
    if (volume < 0.0 || volume > 1.0) {
      Logger().audioError(
        'Invalid volume value: $volume. Must be between 0.0 and 1.0',
      );
      return;
    }

    _globalVolume = volume;
    _isMuted = false; // Unmute when setting volume

    Logger().audioInfo(
      'Global volume set to: ${(_globalVolume * 100).round()}%',
    );

    // Apply volume to all active instances
    await _applyVolumeToAllInstances();
  }

  /// Set mute state
  Future<void> setMuted(bool muted) async {
    _isMuted = muted;
    Logger().audioInfo('Global mute set to: $muted');

    // Apply volume to all active instances
    await _applyVolumeToAllInstances();
  }

  /// Apply current volume settings to all active instances
  Future<void> _applyVolumeToAllInstances() async {
    final effectiveVolume = _isMuted ? 0.0 : _globalVolume;

    for (final instance in _activeInstances.values) {
      try {
        instance.player.setVolume(effectiveVolume);
        Logger().audioDebug(
          'Applied volume ${(effectiveVolume * 100).round()}% to instance',
          filePath: instance.filePath,
        );
      } catch (e) {
        Logger().audioError(
          'Failed to set volume for instance',
          filePath: instance.filePath,
          error: e,
        );
      }
    }
  }

  /// Play audio file (creates new instance for overlapping)
  Future<String> playAudio(String filePath) async {
    try {
      Logger().audioInfo('Request to play audio', filePath: filePath);

      // Generate unique ID for this instance
      final instanceId = '${filePath}_${DateTime.now().millisecondsSinceEpoch}';
      final playerId = _nextPlayerId++;

      // Create new audio instance
      final instance = AudioInstance(
        id: instanceId,
        filePath: filePath,
        playerId: playerId,
      );

      // Add to active instances
      _activeInstances[instanceId] = instance;
      Logger().audioInfo(
        'Added instance to active instances (total: ${_activeInstances.length})',
      );

      // Listen for completion to clean up
      instance.stateStream.listen((state) {
        if (state.isCompleted || (!state.isPlaying && instance.currentPosition == Duration.zero)) {
          _cleanupInstance(instanceId);
        }
      });

      // Apply current volume settings to new instance
      final effectiveVolume = _isMuted ? 0.0 : _globalVolume;
      instance.player.setVolume(effectiveVolume);
      Logger().audioDebug(
        'Applied volume ${(effectiveVolume * 100).round()}% to new instance',
        filePath: filePath,
      );

      // Apply current device if set
      if (_currentDevice != null) {
        instance.setDevice(_currentDevice!);
      }

      // Start playback
      await instance.play();

      // Notify listeners
      _instancesController.add(Map.from(_activeInstances));

      return instanceId;
    } catch (e, stackTrace) {
      Logger().audioError(
        'Failed to play audio',
        filePath: filePath,
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Get specific instance
  AudioInstance? getInstance(String instanceId) {
    return _activeInstances[instanceId];
  }

  /// Get all instances for a specific file path
  List<AudioInstance> getInstancesForFile(String filePath) {
    return _activeInstances.values
        .where((instance) => instance.filePath == filePath)
        .toList();
  }

  /// Get the most recent instance for a file path (for UI progress display)
  AudioInstance? getMostRecentInstanceForFile(String filePath) {
    final instances = getInstancesForFile(filePath);
    if (instances.isEmpty) return null;

    // Sort by instance ID (which contains timestamp) to get most recent
    instances.sort((a, b) => b.id.compareTo(a.id));
    return instances.first;
  }

  /// Pause specific instance
  Future<void> pauseInstance(String instanceId) async {
    final instance = _activeInstances[instanceId];
    if (instance != null) {
      await instance.pause();
      Logger().audioInfo('Paused instance $instanceId');
    } else {
      Logger().audioError('Instance not found for pause: $instanceId');
    }
  }

  /// Resume specific instance
  Future<void> resumeInstance(String instanceId) async {
    final instance = _activeInstances[instanceId];
    if (instance != null) {
      await instance.resume();
      Logger().audioInfo('Resumed instance $instanceId');
    } else {
      Logger().audioError('Instance not found for resume: $instanceId');
    }
  }

  /// Stop specific instance
  Future<void> stopInstance(String instanceId) async {
    final instance = _activeInstances[instanceId];
    if (instance != null) {
      await instance.stop();
      _cleanupInstance(instanceId);
    } else {
      Logger().audioError('Instance not found for stop: $instanceId');
    }
  }

  /// Stop all instances for a specific file
  Future<void> stopAllInstancesForFile(String filePath) async {
    Logger().audioInfo('Stopping all instances', filePath: filePath);
    final instances = getInstancesForFile(filePath);

    for (final instance in instances) {
      try {
        await instance.stop();
      } catch (e) {
        Logger().audioError('Error stopping instance ${instance.id}', error: e);
      }
    }
  }

  /// Stop all instances
  Future<void> stopAllInstances() async {
    Logger().audioInfo(
      'Stopping all active instances (${_activeInstances.length} total)',
    );
    final instances = List.from(_activeInstances.values);

    for (final instance in instances) {
      try {
        await instance.stop();
      } catch (e) {
        Logger().audioError('Error stopping instance ${instance.id}', error: e);
      }
    }

    _cleanupAllInstances();
  }

  /// Clean up specific instance
  void _cleanupInstance(String instanceId) {
    final instance = _activeInstances.remove(instanceId);
    if (instance != null) {
      Logger().audioInfo(
        'Cleaning up instance $instanceId (remaining: ${_activeInstances.length})',
      );
      instance.dispose();
      _instancesController.add(Map.from(_activeInstances));
    }
  }

  /// Clean up all instances
  void _cleanupAllInstances() {
    Logger().audioInfo('Cleaning up all instances');
    for (final instance in _activeInstances.values) {
      try {
        instance.dispose();
      } catch (e) {
        Logger().audioError(
          'Error disposing instance ${instance.id}',
          error: e,
        );
      }
    }
    _activeInstances.clear();
    _instancesController.add({});
  }

  /// Check if any instance of file is playing
  bool isFileCurrentlyPlaying(String filePath) {
    return getInstancesForFile(filePath).any((instance) => instance.isPlaying);
  }

  /// Check if there are any active instances for file
  bool hasActiveInstancesForFile(String filePath) {
    return getInstancesForFile(filePath).isNotEmpty;
  }

  /// Get playing instances count for file
  int getPlayingInstancesCount(String filePath) {
    return getInstancesForFile(
      filePath,
    ).where((instance) => instance.isPlaying).length;
  }

  /// Get total active instances count
  int get totalActiveInstancesCount => _activeInstances.length;

  /// Dispose service
  void dispose() {
    Logger().audioInfo('Disposing MultiAudioService');
    _cleanupAllInstances();
    _instancesController.close();
  }
}
