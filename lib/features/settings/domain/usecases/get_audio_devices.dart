import '../../../../core/usecases/usecase.dart';
import '../entities/audio_device.dart';
import '../services/audio_device_service.dart';

/// Use case for getting all available audio output devices
class GetAudioDevices extends UseCase<List<AudioDevice>, NoParams> {
  final AudioDeviceService audioDeviceService;

  GetAudioDevices(this.audioDeviceService);

  @override
  Future<List<AudioDevice>> call(NoParams params) async {
    return audioDeviceService.getAllDevices();
  }
}

/// Use case for getting only virtual audio cables
class GetVirtualAudioCables extends UseCase<List<AudioDevice>, NoParams> {
  final AudioDeviceService audioDeviceService;

  GetVirtualAudioCables(this.audioDeviceService);

  @override
  Future<List<AudioDevice>> call(NoParams params) async {
    return audioDeviceService.getVirtualAudioCables();
  }
}

/// Use case for detecting the best virtual device
class DetectBestVirtualDevice extends UseCase<AudioDevice?, NoParams> {
  final AudioDeviceService audioDeviceService;

  DetectBestVirtualDevice(this.audioDeviceService);

  @override
  Future<AudioDevice?> call(NoParams params) async {
    return audioDeviceService.detectBestVirtualDevice();
  }
}

/// Use case for loading saved device
class LoadSavedAudioDevice extends UseCase<AudioDevice?, NoParams> {
  final AudioDeviceService audioDeviceService;

  LoadSavedAudioDevice(this.audioDeviceService);

  @override
  Future<AudioDevice?> call(NoParams params) async {
    return await audioDeviceService.loadSavedDevice();
  }
}
