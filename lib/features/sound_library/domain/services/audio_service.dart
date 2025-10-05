import 'package:dart_vlc/dart_vlc.dart';
import '../../../../core/util/logger.dart';
import '../../../settings/domain/entities/audio_device.dart';

/// Service for managing audio playback with dart_vlc
class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal() {
    _audioPlayer = Player(
      id: 0,
      commandlineArguments: ['--no-video'], // Audio-only mode
    );
    Logger().audioInfo('AudioService initialized with dart_vlc');
  }

  late final Player _audioPlayer;
  String? _currentlyPlayingPath;
  bool _isPlaying = false;
  AudioDevice? _currentDevice;

  /// Get the current audio player instance
  Player get audioPlayer => _audioPlayer;

  /// Check if audio is currently playing
  bool get isPlaying => _isPlaying;

  /// Get the currently playing file path
  String? get currentlyPlayingPath => _currentlyPlayingPath;

  /// Get current audio device
  AudioDevice? get currentDevice => _currentDevice;

  /// Set audio output device
  void setDevice(AudioDevice? device) {
    if (device == null) return;

    try {
      Logger().audioInfo(
        'Setting audio device to: ${device.name}',
        filePath: device.id,
      );

      // Get dart_vlc Device object
      final vlcDevices = Devices.all;
      final vlcDevice = vlcDevices.firstWhere(
        (d) => d.id == device.id,
        orElse: () => vlcDevices.first,
      );

      // Set device on player
      _audioPlayer.setDevice(vlcDevice);
      _currentDevice = device;

      Logger().audioInfo(
        'Audio device set successfully: ${device.name}',
      );
    } catch (e, stackTrace) {
      Logger().audioError(
        'Failed to set audio device',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Play audio from file path
  Future<void> playAudio(String filePath) async {
    try {
      Logger().audioInfo(
        'AudioService - Playing audio',
        filePath: filePath,
      );

      // If already playing the same file, pause it
      if (_isPlaying && _currentlyPlayingPath == filePath) {
        Logger().audioInfo(
          'Same file already playing, pausing',
          filePath: filePath,
        );
        await pauseAudio();
        return;
      }

      // Stop current audio if playing different file
      if (_isPlaying && _currentlyPlayingPath != filePath) {
        Logger().audioInfo(
          'Stopping current audio before playing new',
          filePath: _currentlyPlayingPath,
        );
        await stopAudio();
      }

      // Create media and play
      final media = Media.file(filePath);
      _audioPlayer.open(media, autoStart: true);

      _currentlyPlayingPath = filePath;
      _isPlaying = true;
      Logger().audioInfo(
        'Audio playback started successfully',
        filePath: filePath,
      );
    } catch (e, stackTrace) {
      Logger().audioError(
        'Failed to play audio',
        filePath: filePath,
        error: e,
        stackTrace: stackTrace,
      );
      throw Exception('Error al reproducir audio: $e');
    }
  }

  /// Pause current audio
  Future<void> pauseAudio() async {
    try {
      Logger().audioInfo('Pausing audio', filePath: _currentlyPlayingPath);
      await _audioPlayer.pause();
      _isPlaying = false;
    } catch (e, stackTrace) {
      Logger().audioError(
        'Failed to pause audio',
        filePath: _currentlyPlayingPath,
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Resume current audio
  Future<void> resumeAudio() async {
    try {
      Logger().audioInfo('Resuming audio', filePath: _currentlyPlayingPath);
      await _audioPlayer.resume();
      _isPlaying = true;
    } catch (e, stackTrace) {
      Logger().audioError(
        'Failed to resume audio',
        filePath: _currentlyPlayingPath,
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Stop current audio
  Future<void> stopAudio() async {
    try {
      Logger().audioInfo('Stopping audio', filePath: _currentlyPlayingPath);
      await _audioPlayer.stop();
      _currentlyPlayingPath = null;
      _isPlaying = false;
    } catch (e, stackTrace) {
      Logger().audioError(
        'Failed to stop audio',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Seek to specific position
  Future<void> seekTo(Duration position) async {
    try {
      Logger().audioDebug(
        'Seeking to position: ${position.inMilliseconds}ms',
        filePath: _currentlyPlayingPath,
      );
      await _audioPlayer.seek(position);
    } catch (e, stackTrace) {
      Logger().audioError(
        'Failed to seek',
        filePath: _currentlyPlayingPath,
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Get current position
  Stream<Duration?> get positionStream =>
      _audioPlayer.positionStream.map((pos) => pos.position);

  /// Get duration
  Stream<Duration?> get durationStream =>
      _audioPlayer.positionStream.map((pos) => pos.duration);

  /// Listen to player state changes
  Stream<PlaybackState> get playerStateStream => _audioPlayer.playbackStream;

  /// Dispose resources
  void dispose() {
    Logger().audioInfo('Disposing AudioService (legacy)');
    try {
      _audioPlayer.dispose();
    } catch (e, stackTrace) {
      Logger().audioError(
        'Error disposing AudioPlayer',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }
}
