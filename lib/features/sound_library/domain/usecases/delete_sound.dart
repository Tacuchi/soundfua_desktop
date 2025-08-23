import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/sound_repository.dart';

/// Parameters for deleting a sound
class DeleteSoundParams {
  final int id;

  const DeleteSoundParams({required this.id});
}

/// Use case for deleting a sound
class DeleteSound implements UseCase<void, DeleteSoundParams> {
  final SoundRepository repository;

  DeleteSound(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteSoundParams params) async {
    return await repository.deleteSound(params.id);
  }
}
