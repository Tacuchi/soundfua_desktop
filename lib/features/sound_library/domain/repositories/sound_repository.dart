import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/sound.dart';

/// Abstract repository interface for sound operations
abstract class SoundRepository {
  /// Get all sounds from the repository
  Future<Either<Failure, List<Sound>>> getAllSounds();

  /// Add a new sound to the repository
  Future<Either<Failure, Sound>> addSound(Sound sound);

  /// Delete a sound from the repository
  Future<Either<Failure, void>> deleteSound(int id);

  /// Update sound information in the repository
  Future<Either<Failure, Sound>> updateSound(Sound sound);

  /// Get a sound by its ID
  Future<Either<Failure, Sound>> getSoundById(int id);
}
