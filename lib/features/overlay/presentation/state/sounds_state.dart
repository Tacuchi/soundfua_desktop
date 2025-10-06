import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:soundfua_desktop/features/overlay/domain/entities/sound.dart';

part 'sounds_state.freezed.dart';

@freezed
class SoundsState with _$SoundsState {
  const factory SoundsState.initial() = _Initial;
  const factory SoundsState.loading() = _Loading;
  const factory SoundsState.loaded({
    required List<Sound> sounds,
    required int count,
  }) = _Loaded;
  const factory SoundsState.syncing() = _Syncing;
  const factory SoundsState.error(String message) = _Error;
}
