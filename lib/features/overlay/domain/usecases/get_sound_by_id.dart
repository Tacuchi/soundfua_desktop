import 'package:dartz/dartz.dart';
import 'package:soundfua_desktop/core/error/failures.dart';
import 'package:soundfua_desktop/core/usecases/usecase.dart';
import 'package:soundfua_desktop/features/overlay/domain/entities/sound.dart';
import 'package:soundfua_desktop/features/overlay/domain/repositories/sound_repository.dart';

class GetSoundByIdParams {
  final int id;

  const GetSoundByIdParams(this.id);
}

class GetSoundByIdUseCase implements UseCase<Sound, GetSoundByIdParams> {
  final SoundRepository repository;

  GetSoundByIdUseCase(this.repository);

  @override
  Future<Either<Failure, Sound>> call(GetSoundByIdParams params) async {
    return await repository.getSoundById(params.id);
  }
}
