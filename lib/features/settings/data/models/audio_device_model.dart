import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/audio_device.dart';

part 'audio_device_model.freezed.dart';
part 'audio_device_model.g.dart';

/// Data model for AudioDevice
@freezed
class AudioDeviceModel with _$AudioDeviceModel {
  const factory AudioDeviceModel({
    required String id,
    required String name,
    @Default(false) bool isVirtualCable,
    @Default(false) bool isDefault,
    @Default(false) bool isSelected,
  }) = _AudioDeviceModel;

  factory AudioDeviceModel.fromJson(Map<String, dynamic> json) =>
      _$AudioDeviceModelFromJson(json);
}

/// Extension to convert between model and entity
extension AudioDeviceModelX on AudioDeviceModel {
  /// Convert model to entity
  AudioDevice toEntity() {
    return AudioDevice(
      id: id,
      name: name,
      isVirtualCable: isVirtualCable,
      isDefault: isDefault,
      isSelected: isSelected,
    );
  }
}

/// Extension to convert entity to model
extension AudioDeviceX on AudioDevice {
  /// Convert entity to model
  AudioDeviceModel toModel() {
    return AudioDeviceModel(
      id: id,
      name: name,
      isVirtualCable: isVirtualCable,
      isDefault: isDefault,
      isSelected: isSelected,
    );
  }
}
