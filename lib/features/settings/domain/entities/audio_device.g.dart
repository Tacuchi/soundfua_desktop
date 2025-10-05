// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AudioDeviceImpl _$$AudioDeviceImplFromJson(Map<String, dynamic> json) =>
    _$AudioDeviceImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      isVirtualCable: json['isVirtualCable'] as bool? ?? false,
      isDefault: json['isDefault'] as bool? ?? false,
      isSelected: json['isSelected'] as bool? ?? false,
    );

Map<String, dynamic> _$$AudioDeviceImplToJson(_$AudioDeviceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isVirtualCable': instance.isVirtualCable,
      'isDefault': instance.isDefault,
      'isSelected': instance.isSelected,
    };
