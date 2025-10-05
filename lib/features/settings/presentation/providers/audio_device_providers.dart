import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/audio_device.dart';
import '../../domain/services/audio_device_service.dart';
import '../../../../core/di/injection.dart';

/// Provider for AudioDeviceService
final audioDeviceServiceProvider = Provider<AudioDeviceService>((ref) {
  return AudioDeviceService();
});

/// Provider for all available audio devices
final audioDevicesProvider = FutureProvider<List<AudioDevice>>((ref) async {
  final service = ref.watch(audioDeviceServiceProvider);
  return service.getAllDevices();
});

/// Provider for virtual audio cables only
final virtualAudioCablesProvider = FutureProvider<List<AudioDevice>>((ref) async {
  final service = ref.watch(audioDeviceServiceProvider);
  return service.getVirtualAudioCables();
});

/// Provider for currently selected audio device
final selectedAudioDeviceProvider = StateProvider<AudioDevice?>((ref) => null);

/// Provider for checking if virtual cable is installed
final hasVirtualCableProvider = Provider<bool>((ref) {
  final service = ref.watch(audioDeviceServiceProvider);
  return service.hasVirtualCableInstalled();
});

/// Provider for recommended device message
final recommendedDeviceMessageProvider = Provider<String>((ref) {
  final service = ref.watch(audioDeviceServiceProvider);
  return service.getRecommendedDeviceMessage();
});

/// Provider for auto-detecting best virtual device
final autoDetectVirtualDeviceProvider = Provider<AudioDevice?>((ref) {
  final service = ref.watch(audioDeviceServiceProvider);
  return service.detectBestVirtualDevice();
});

/// Notifier for managing audio device selection
class AudioDeviceNotifier extends StateNotifier<AudioDevice?> {
  final AudioDeviceService _service;

  AudioDeviceNotifier(this._service) : super(null) {
    _loadSavedDevice();
  }

  /// Load saved device on initialization
  Future<void> _loadSavedDevice() async {
    final savedDevice = await _service.loadSavedDevice();
    if (savedDevice != null) {
      state = savedDevice;
    }
  }

  /// Select a new audio device
  Future<void> selectDevice(AudioDevice device) async {
    await _service.saveSelectedDevice(device);
    state = device;
  }

  /// Auto-detect and select best virtual device
  Future<bool> autoDetectAndSelect() async {
    final bestDevice = _service.detectBestVirtualDevice();
    if (bestDevice != null) {
      await selectDevice(bestDevice);
      return true;
    }
    return false;
  }

  /// Clear selected device (use system default)
  Future<void> clearSelection() async {
    await _service.clearSavedDevice();
    state = null;
  }

  /// Refresh current device info
  void refresh() {
    if (state != null) {
      final devices = _service.getAllDevices();
      final updated = devices.firstWhere(
        (d) => d.id == state!.id,
        orElse: () => state!,
      );
      state = updated.copyWith(isSelected: true);
    }
  }
}

/// Provider for audio device notifier
final audioDeviceNotifierProvider =
    StateNotifierProvider<AudioDeviceNotifier, AudioDevice?>((ref) {
  final service = ref.watch(audioDeviceServiceProvider);
  return AudioDeviceNotifier(service);
});
