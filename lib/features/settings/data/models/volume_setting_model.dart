import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/volume_setting.dart';

part 'volume_setting_model.freezed.dart';
part 'volume_setting_model.g.dart';

/// Model for volume setting that extends the domain entity
@freezed
class VolumeSettingModel with _$VolumeSettingModel {
  const factory VolumeSettingModel({
    @Default(0.7) double masterVolume,
    @Default(false) bool isMuted,
  }) = _VolumeSettingModel;

  factory VolumeSettingModel.fromJson(Map<String, dynamic> json) =>
      _$VolumeSettingModelFromJson(json);

  /// Convert from domain entity to model
  factory VolumeSettingModel.fromEntity(VolumeSetting entity) {
    return VolumeSettingModel(
      masterVolume: entity.masterVolume,
      isMuted: entity.isMuted,
    );
  }
}

/// Extension to convert model to domain entity
extension VolumeSettingModelExtension on VolumeSettingModel {
  VolumeSetting toEntity() {
    return VolumeSetting(masterVolume: masterVolume, isMuted: isMuted);
  }

  /// Get volume description for logging (delegates to entity)
  String get volumeDescription {
    return toEntity().volumeDescription;
  }
}
