import 'package:dartz/dartz.dart';
import 'package:soundfua_desktop/core/error/failures.dart';
import 'package:soundfua_desktop/features/audio/domain/services/audio_service.dart';
import 'package:soundfua_desktop/features/overlay/domain/repositories/sound_repository.dart';

class PlaySound {
  final AudioService audioService;
  final SoundRepository soundRepository;

  PlaySound({
    required this.audioService,
    required this.soundRepository,
  });

  Future<Either<Failure, void>> call(int soundId) async {
    final soundResult = await soundRepository.getSoundById(soundId);

    return soundResult.fold(
      (failure) => Left(failure),
      (sound) async {
        return await audioService.playSound(sound.filePath);
      },
    );
  }
}
