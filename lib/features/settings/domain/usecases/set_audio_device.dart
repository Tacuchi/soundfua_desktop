import '../../../../core/usecases/usecase.dart';
import '../entities/audio_device.dart';
import '../services/audio_device_service.dart';

/// Use case for setting the selected audio output device
class SetAudioDevice extends UseCase<void, SetAudioDeviceParams> {
  final AudioDeviceService audioDeviceService;

  SetAudioDevice(this.audioDeviceService);

  @override
  Future<void> call(SetAudioDeviceParams params) async {
    await audioDeviceService.saveSelectedDevice(params.device);
  }
}

/// Parameters for SetAudioDevice use case
class SetAudioDeviceParams {
  final AudioDevice device;

  SetAudioDeviceParams({required this.device});
}
