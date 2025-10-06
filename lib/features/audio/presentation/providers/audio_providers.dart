import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soundfua_desktop/features/audio/data/services/audio_device_service_impl.dart';
import 'package:soundfua_desktop/features/audio/data/services/audio_service_impl.dart';
import 'package:soundfua_desktop/features/audio/domain/entities/audio_device.dart';
import 'package:soundfua_desktop/features/audio/domain/services/audio_device_service.dart';
import 'package:soundfua_desktop/features/audio/domain/services/audio_service.dart';
import 'package:soundfua_desktop/features/audio/domain/usecases/play_sound.dart';
import 'package:soundfua_desktop/features/overlay/presentation/providers/sound_providers.dart';

final audioDeviceServiceProvider = Provider<AudioDeviceService>((ref) {
  return AudioDeviceServiceImpl();
});

final audioServiceProvider = Provider<AudioService>((ref) {
  return AudioServiceImpl();
});

final playSoundUseCaseProvider = Provider<PlaySound>((ref) {
  return PlaySound(
    audioService: ref.watch(audioServiceProvider),
    soundRepository: ref.watch(soundRepositoryProvider),
  );
});

final availableAudioDevicesProvider = FutureProvider<List<AudioDevice>>((ref) async {
  final service = ref.watch(audioDeviceServiceProvider);
  final result = await service.getAvailableDevices();
  
  return result.fold(
    (failure) => [],
    (devices) => devices,
  );
});

final detectedVirtualCableProvider = FutureProvider<AudioDevice?>((ref) async {
  final service = ref.watch(audioDeviceServiceProvider);
  final result = await service.detectVirtualCable();
  
  return result.fold(
    (failure) => null,
    (device) => device,
  );
});

final selectedAudioDeviceProvider = StateNotifierProvider<SelectedAudioDeviceNotifier, AudioDevice?>((ref) {
  return SelectedAudioDeviceNotifier(ref);
});

class SelectedAudioDeviceNotifier extends StateNotifier<AudioDevice?> {
  final Ref ref;

  SelectedAudioDeviceNotifier(this.ref) : super(null) {
    _loadSelectedDevice();
  }

  Future<void> _loadSelectedDevice() async {
    final prefs = await SharedPreferences.getInstance();
    final deviceId = prefs.getString('selected_audio_device_id');
    final deviceName = prefs.getString('selected_audio_device_name');

    if (deviceId != null && deviceName != null) {
      final isVirtual = prefs.getBool('selected_audio_device_is_virtual') ?? false;
      state = AudioDevice(
        id: deviceId,
        name: deviceName,
        isVirtualCable: isVirtual,
      );

      final audioService = ref.read(audioServiceProvider);
      await audioService.setOutputDevice(deviceId);
    }
  }

  Future<void> selectDevice(AudioDevice device) async {
    state = device;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_audio_device_id', device.id);
    await prefs.setString('selected_audio_device_name', device.name);
    await prefs.setBool('selected_audio_device_is_virtual', device.isVirtualCable);

    final audioService = ref.read(audioServiceProvider);
    await audioService.setOutputDevice(device.id);
  }

  Future<void> autoDetectVirtualCable() async {
    final cableResult = await ref.read(detectedVirtualCableProvider.future);
    if (cableResult != null) {
      await selectDevice(cableResult);
    }
  }
}

final audioVolumeProvider = StateNotifierProvider<AudioVolumeNotifier, double>((ref) {
  return AudioVolumeNotifier(ref);
});

class AudioVolumeNotifier extends StateNotifier<double> {
  final Ref ref;

  AudioVolumeNotifier(this.ref) : super(1.0) {
    _loadVolume();
  }

  Future<void> _loadVolume() async {
    final prefs = await SharedPreferences.getInstance();
    final volume = prefs.getDouble('audio_volume') ?? 1.0;
    state = volume;

    final audioService = ref.read(audioServiceProvider);
    await audioService.setVolume(volume);
  }

  Future<void> setVolume(double volume) async {
    if (volume < 0.0 || volume > 1.0) return;

    state = volume;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('audio_volume', volume);

    final audioService = ref.read(audioServiceProvider);
    await audioService.setVolume(volume);
  }
}
