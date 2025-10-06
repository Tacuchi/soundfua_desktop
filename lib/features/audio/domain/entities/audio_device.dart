import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_device.freezed.dart';

@freezed
class AudioDevice with _$AudioDevice {
  const factory AudioDevice({
    required String id,
    required String name,
    required bool isVirtualCable,
    String? description,
  }) = _AudioDevice;

  const AudioDevice._();

  bool get isBlackHole => name.toLowerCase().contains('blackhole');
  bool get isVBCable => name.toLowerCase().contains('vb-audio') ||
      name.toLowerCase().contains('cable');
  bool get isPulseAudio => name.toLowerCase().contains('pulse');
}
