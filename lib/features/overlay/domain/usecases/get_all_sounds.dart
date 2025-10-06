import 'package:dartz/dartz.dart';
import 'package:soundfua_desktop/core/error/failures.dart';
import 'package:soundfua_desktop/core/usecases/usecase.dart';
import 'package:soundfua_desktop/features/overlay/domain/entities/sound.dart';
import 'package:soundfua_desktop/features/overlay/domain/repositories/sound_repository.dart';

class GetAllSoundsUseCase implements UseCase<List<Sound>, NoParams> {
  final SoundRepository repository;

  GetAllSoundsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Sound>>> call(NoParams params) async {
    return await repository.getAllSounds();
  }
}
