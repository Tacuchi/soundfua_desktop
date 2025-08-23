import '../../domain/entities/sound.dart';

/// Model that extends Sound entity for data operations
class SoundModel {
  final int? id;
  final String filePath;
  final String alias;
  final DateTime addedOn;

  const SoundModel({
    this.id,
    required this.filePath,
    required this.alias,
    required this.addedOn,
  });

  /// Create SoundModel from Sound entity
  factory SoundModel.fromEntity(Sound sound) {
    return SoundModel(
      id: sound.id,
      filePath: sound.filePath,
      alias: sound.alias,
      addedOn: sound.addedOn,
    );
  }

  /// Convert to Sound entity
  Sound toEntity() {
    return Sound(id: id, filePath: filePath, alias: alias, addedOn: addedOn);
  }

  /// Create SoundModel from JSON
  factory SoundModel.fromJson(Map<String, dynamic> json) {
    return SoundModel(
      id: json['id'] as int?,
      filePath: json['filePath'] as String,
      alias: json['alias'] as String,
      addedOn: DateTime.parse(json['addedOn'] as String),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'filePath': filePath,
      'alias': alias,
      'addedOn': addedOn.toIso8601String(),
    };
  }
}
