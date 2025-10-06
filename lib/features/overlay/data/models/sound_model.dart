import 'package:drift/drift.dart' as drift;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:soundfua_desktop/features/overlay/data/datasources/local/app_database.dart';
import 'package:soundfua_desktop/features/overlay/domain/entities/sound.dart';

part 'sound_model.freezed.dart';
part 'sound_model.g.dart';

@freezed
class SoundModel with _$SoundModel {
  const SoundModel._();

  const factory SoundModel({
    int? id,
    required String fileName,
    required String filePath,
    required int fileSize,
    required DateTime addedOn,
    required DateTime lastModified,
    @Default(0) int playCount,
    DateTime? lastPlayedAt,
  }) = _SoundModel;

  factory SoundModel.fromJson(Map<String, dynamic> json) =>
      _$SoundModelFromJson(json);

  factory SoundModel.fromEntity(Sound entity) {
    return SoundModel(
      id: entity.id,
      fileName: entity.fileName,
      filePath: entity.filePath,
      fileSize: entity.fileSize,
      addedOn: entity.addedOn,
      lastModified: entity.lastModified,
      playCount: entity.playCount,
      lastPlayedAt: entity.lastPlayedAt,
    );
  }

  factory SoundModel.fromEntry(SoundEntry entry) {
    return SoundModel(
      id: entry.id,
      fileName: entry.fileName,
      filePath: entry.filePath,
      fileSize: entry.fileSize,
      addedOn: entry.addedOn,
      lastModified: entry.lastModified,
      playCount: entry.playCount,
      lastPlayedAt: entry.lastPlayedAt,
    );
  }

  Sound toEntity() {
    return Sound(
      id: id,
      fileName: fileName,
      filePath: filePath,
      fileSize: fileSize,
      addedOn: addedOn,
      lastModified: lastModified,
      playCount: playCount,
      lastPlayedAt: lastPlayedAt,
    );
  }

  SoundsCompanion toCompanion() {
    return SoundsCompanion(
      id: id != null ? drift.Value(id!) : const drift.Value.absent(),
      fileName: drift.Value(fileName),
      filePath: drift.Value(filePath),
      fileSize: drift.Value(fileSize),
      addedOn: drift.Value(addedOn),
      lastModified: drift.Value(lastModified),
      playCount: drift.Value(playCount),
      lastPlayedAt: lastPlayedAt != null
          ? drift.Value(lastPlayedAt)
          : const drift.Value.absent(),
    );
  }
}
