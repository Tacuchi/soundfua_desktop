import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../domain/services/audio_service.dart';

/// Provider for the audio service
final audioServiceProvider = Provider<AudioService>((ref) {
  return AudioService();
});

/// State class for audio player
class AudioPlayerState {
  final bool isPlaying;
  final String? currentlyPlayingPath;
  final Duration currentPosition;
  final Duration totalDuration;
  final PlayerState playerState;

  const AudioPlayerState({
    this.isPlaying = false,
    this.currentlyPlayingPath,
    this.currentPosition = Duration.zero,
    this.totalDuration = Duration.zero,
    this.playerState = PlayerState.stopped,
  });

  AudioPlayerState copyWith({
    bool? isPlaying,
    String? currentlyPlayingPath,
    Duration? currentPosition,
    Duration? totalDuration,
    PlayerState? playerState,
  }) {
    return AudioPlayerState(
      isPlaying: isPlaying ?? this.isPlaying,
      currentlyPlayingPath: currentlyPlayingPath ?? this.currentlyPlayingPath,
      currentPosition: currentPosition ?? this.currentPosition,
      totalDuration: totalDuration ?? this.totalDuration,
      playerState: playerState ?? this.playerState,
    );
  }
}

/// Audio player notifier
class AudioPlayerNotifier extends StateNotifier<AudioPlayerState> {
  final AudioService _audioService;

  AudioPlayerNotifier(this._audioService) : super(const AudioPlayerState()) {
    _initializeListeners();
  }

  void _initializeListeners() {
    // Listen to position changes
    _audioService.positionStream.listen((position) {
      state = state.copyWith(currentPosition: position);
    });

    // Listen to duration changes
    _audioService.durationStream.listen((duration) {
      state = state.copyWith(totalDuration: duration);
    });

    // Listen to player state changes
    _audioService.playerStateStream.listen((playerState) {
      state = state.copyWith(
        playerState: playerState,
        isPlaying: playerState == PlayerState.playing,
        currentlyPlayingPath: playerState == PlayerState.stopped
            ? null
            : _audioService.currentlyPlayingPath,
      );
    });
  }

  /// Play or pause audio
  Future<void> togglePlayPause(String filePath) async {
    try {
      if (state.currentlyPlayingPath == filePath && state.isPlaying) {
        await _audioService.pauseAudio();
      } else if (state.currentlyPlayingPath == filePath && !state.isPlaying) {
        await _audioService.resumeAudio();
      } else {
        await _audioService.playAudio(filePath);
      }
    } catch (e) {
      // Handle error
      rethrow;
    }
  }

  /// Stop audio
  Future<void> stopAudio() async {
    await _audioService.stopAudio();
  }

  /// Seek to position
  Future<void> seekTo(Duration position) async {
    await _audioService.seekTo(position);
  }

  /// Check if specific file is currently playing
  bool isFileCurrentlyPlaying(String filePath) {
    return state.currentlyPlayingPath == filePath && state.isPlaying;
  }

  /// Check if specific file is the current file (paused or playing)
  bool isCurrentFile(String filePath) {
    return state.currentlyPlayingPath == filePath;
  }

  @override
  void dispose() {
    _audioService.dispose();
    super.dispose();
  }
}

/// Provider for the audio player notifier
final audioPlayerProvider =
    StateNotifierProvider<AudioPlayerNotifier, AudioPlayerState>((ref) {
      final audioService = ref.read(audioServiceProvider);
      return AudioPlayerNotifier(audioService);
    });
