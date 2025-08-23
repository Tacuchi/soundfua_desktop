import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/sound.dart';
import '../repositories/sound_repository.dart';

/// Parameters for adding a sound
class AddSoundParams {
  final String filePath;
  final String alias;

  const AddSoundParams({required this.filePath, required this.alias});
}

/// Use case for adding a new sound
class AddSound implements UseCase<Sound, AddSoundParams> {
  final SoundRepository repository;

  AddSound(this.repository);

  @override
  Future<Either<Failure, Sound>> call(AddSoundParams params) async {
    final sound = Sound(
      filePath: params.filePath,
      alias: params.alias,
      addedOn: DateTime.now(),
    );

    return await repository.addSound(sound);
  }
}
