// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volume_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VolumeSettingImpl _$$VolumeSettingImplFromJson(Map<String, dynamic> json) =>
    _$VolumeSettingImpl(
      masterVolume: (json['masterVolume'] as num?)?.toDouble() ?? 0.7,
      isMuted: json['isMuted'] as bool? ?? false,
    );

Map<String, dynamic> _$$VolumeSettingImplToJson(_$VolumeSettingImpl instance) =>
    <String, dynamic>{
      'masterVolume': instance.masterVolume,
      'isMuted': instance.isMuted,
    };
