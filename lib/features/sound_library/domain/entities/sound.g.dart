// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sound.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SoundImpl _$$SoundImplFromJson(Map<String, dynamic> json) => _$SoundImpl(
  id: (json['id'] as num?)?.toInt(),
  filePath: json['filePath'] as String,
  alias: json['alias'] as String,
  addedOn: DateTime.parse(json['addedOn'] as String),
);

Map<String, dynamic> _$$SoundImplToJson(_$SoundImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'filePath': instance.filePath,
      'alias': instance.alias,
      'addedOn': instance.addedOn.toIso8601String(),
    };
