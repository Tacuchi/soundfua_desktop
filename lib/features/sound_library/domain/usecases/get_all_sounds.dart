import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/sound.dart';
import '../repositories/sound_repository.dart';

/// Use case for getting all sounds
class GetAllSounds implements UseCase<List<Sound>, NoParams> {
  final SoundRepository repository;

  GetAllSounds(this.repository);

  @override
  Future<Either<Failure, List<Sound>>> call(NoParams params) async {
    return await repository.getAllSounds();
  }
}
