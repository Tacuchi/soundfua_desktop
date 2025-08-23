import 'package:freezed_annotation/freezed_annotation.dart';

part 'sound.freezed.dart';
part 'sound.g.dart';

@freezed
class Sound with _$Sound {
  const factory Sound({
    int? id,
    required String filePath,
    required String alias,
    required DateTime addedOn,
  }) = _Sound;

  factory Sound.fromJson(Map<String, dynamic> json) => _$SoundFromJson(json);
}
