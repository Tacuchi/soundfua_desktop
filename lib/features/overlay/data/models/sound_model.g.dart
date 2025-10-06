// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sound_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SoundModelImpl _$$SoundModelImplFromJson(Map<String, dynamic> json) =>
    _$SoundModelImpl(
      id: (json['id'] as num?)?.toInt(),
      fileName: json['fileName'] as String,
      filePath: json['filePath'] as String,
      fileSize: (json['fileSize'] as num).toInt(),
      addedOn: DateTime.parse(json['addedOn'] as String),
      lastModified: DateTime.parse(json['lastModified'] as String),
      playCount: (json['playCount'] as num?)?.toInt() ?? 0,
      lastPlayedAt: json['lastPlayedAt'] == null
          ? null
          : DateTime.parse(json['lastPlayedAt'] as String),
    );

Map<String, dynamic> _$$SoundModelImplToJson(_$SoundModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fileName': instance.fileName,
      'filePath': instance.filePath,
      'fileSize': instance.fileSize,
      'addedOn': instance.addedOn.toIso8601String(),
      'lastModified': instance.lastModified.toIso8601String(),
      'playCount': instance.playCount,
      'lastPlayedAt': instance.lastPlayedAt?.toIso8601String(),
    };
