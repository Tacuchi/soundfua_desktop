import 'package:freezed_annotation/freezed_annotation.dart';

part 'sound.freezed.dart';

@freezed
class Sound with _$Sound {
  const factory Sound({
    int? id,
    required String fileName,
    required String filePath,
    required int fileSize,
    required DateTime addedOn,
    required DateTime lastModified,
    @Default(0) int playCount,
    DateTime? lastPlayedAt,
  }) = _Sound;
}
