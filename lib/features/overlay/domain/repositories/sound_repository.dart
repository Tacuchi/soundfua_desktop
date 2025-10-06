import 'package:dartz/dartz.dart';
import 'package:soundfua_desktop/core/error/failures.dart';
import 'package:soundfua_desktop/features/overlay/domain/entities/sound.dart';

abstract class SoundRepository {
  Future<Either<Failure, List<Sound>>> getAllSounds();
  Future<Either<Failure, Sound>> getSoundById(int id);
  Future<Either<Failure, void>> syncFolder(String folderPath);
  Future<Either<Failure, void>> deleteAllSounds();
}
