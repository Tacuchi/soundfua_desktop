import 'package:audioplayers/audioplayers.dart';
import '../../../../core/util/logger.dart';

/// Service for managing audio playback
class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal() {
    Logger().audioInfo('AudioService (legacy) initialized');
  }

  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentlyPlayingPath;
  bool _isPlaying = false;

  /// Get the current audio player instance
  AudioPlayer get audioPlayer => _audioPlayer;

  /// Check if audio is currently playing
  bool get isPlaying => _isPlaying;

  /// Get the currently playing file path
  String? get currentlyPlayingPath => _currentlyPlayingPath;

  /// Play audio from file path
  Future<void> playAudio(String filePath) async {
    try {
      Logger().audioInfo(
        'Legacy AudioService - Playing audio',
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

      await _audioPlayer.play(DeviceFileSource(filePath));
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
  Stream<Duration> get positionStream => _audioPlayer.onPositionChanged;

  /// Get duration
  Stream<Duration> get durationStream => _audioPlayer.onDurationChanged;

  /// Listen to player state changes
  Stream<PlayerState> get playerStateStream =>
      _audioPlayer.onPlayerStateChanged;

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
