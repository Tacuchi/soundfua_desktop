import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/sound.dart';

part 'sound_state.freezed.dart';

@freezed
class SoundsState with _$SoundsState {
  const factory SoundsState({
    @Default(false) bool isLoading,
    @Default([]) List<Sound> sounds,
    String? error,
  }) = _SoundsState;
}
