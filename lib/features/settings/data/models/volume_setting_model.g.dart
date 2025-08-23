// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volume_setting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VolumeSettingModelImpl _$$VolumeSettingModelImplFromJson(
  Map<String, dynamic> json,
) => _$VolumeSettingModelImpl(
  masterVolume: (json['masterVolume'] as num?)?.toDouble() ?? 0.7,
  isMuted: json['isMuted'] as bool? ?? false,
);

Map<String, dynamic> _$$VolumeSettingModelImplToJson(
  _$VolumeSettingModelImpl instance,
) => <String, dynamic>{
  'masterVolume': instance.masterVolume,
  'isMuted': instance.isMuted,
};
