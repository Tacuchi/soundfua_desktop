import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/util/logger.dart';
import '../../domain/entities/sound.dart';
import '../../domain/repositories/sound_repository.dart';
import '../datasources/local/sound_local_data_source.dart';
import '../datasources/file/sound_file_data_source.dart';
import '../helpers/file_storage_helper.dart';
import '../models/sound_model.dart';

/// Implementation of SoundRepository
class SoundRepositoryImpl implements SoundRepository {
  final SoundLocalDataSource localDataSource;
  final SoundFileDataSource fileDataSource;

  SoundRepositoryImpl({
    required this.localDataSource,
    required this.fileDataSource,
  });

  @override
  Future<Either<Failure, List<Sound>>> getAllSounds() async {
    try {
      Logger().info('Getting all sounds from database', tag: 'REPOSITORY');

      final soundModels = await localDataSource.getAllSounds();
      final sounds = <Sound>[];
      final invalidSounds = <int>[];

      // Validate each sound file exists
      for (final model in soundModels) {
        final fileExists = await FileStorageHelper.fileExists(model.filePath);
        if (fileExists) {
          sounds.add(model.toEntity());
        } else {
          Logger().warning(
            'Sound file missing: ${model.filePath} (id: ${model.id})',
            tag: 'REPOSITORY',
          );
          if (model.id != null) {
            invalidSounds.add(model.id!);
          }
        }
      }

      // Clean up invalid sounds from database
      if (invalidSounds.isNotEmpty) {
        Logger().info(
          'Cleaning up ${invalidSounds.length} invalid sounds',
          tag: 'REPOSITORY',
        );
        for (final id in invalidSounds) {
          try {
            await localDataSource.deleteSound(id);
          } catch (e) {
            Logger().error(
              'Error cleaning up invalid sound $id',
              tag: 'REPOSITORY',
              error: e,
            );
          }
        }
      }

      Logger().info(
        'Retrieved ${sounds.length} valid sounds',
        tag: 'REPOSITORY',
      );
      return Right(sounds);
    } catch (e) {
      Logger().error('Failed to get sounds', tag: 'REPOSITORY', error: e);
      return Left(
        Failure.databaseFailure('Failed to get sounds: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, Sound>> addSound(Sound sound) async {
    try {
      Logger().info(
        'Adding sound: ${sound.alias} from ${sound.filePath}',
        tag: 'REPOSITORY',
      );

      // Validate original file exists
      if (!fileDataSource.fileExists(sound.filePath)) {
        Logger().error(
          'Source file does not exist: ${sound.filePath}',
          tag: 'REPOSITORY',
        );
        return Left(
          Failure.fileFailure('File does not exist: ${sound.filePath}'),
        );
      }

      // Validate audio format
      if (!fileDataSource.isValidAudioFile(sound.filePath)) {
        Logger().error(
          'Invalid audio format: ${sound.filePath}',
          tag: 'REPOSITORY',
        );
        return Left(Failure.validationFailure('Invalid audio file format'));
      }

      // Copy file to internal storage
      final internalFilePath =
          await FileStorageHelper.copyFileToSoundsDirectory(sound.filePath);
      Logger().info(
        'File copied to internal storage: $internalFilePath',
        tag: 'REPOSITORY',
      );

      // Create sound with internal file path
      final soundWithInternalPath = Sound(
        id: sound.id,
        filePath: internalFilePath,
        alias: sound.alias,
        addedOn: sound.addedOn,
      );

      final soundModel = SoundModel.fromEntity(soundWithInternalPath);
      final addedModel = await localDataSource.addSound(soundModel);

      Logger().info(
        'Sound added successfully: ${addedModel.alias}',
        tag: 'REPOSITORY',
      );
      return Right(addedModel.toEntity());
    } catch (e) {
      Logger().error('Failed to add sound', tag: 'REPOSITORY', error: e);
      return Left(
        Failure.databaseFailure('Failed to add sound: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteSound(int id) async {
    try {
      Logger().info('Deleting sound with id: $id', tag: 'REPOSITORY');

      // Get the sound first to obtain the file path
      final soundModel = await localDataSource.getSoundById(id);
      if (soundModel != null) {
        // Delete the physical file
        final fileDeleted = await FileStorageHelper.deleteFile(
          soundModel.filePath,
        );
        if (fileDeleted) {
          Logger().info(
            'Physical file deleted: ${soundModel.filePath}',
            tag: 'REPOSITORY',
          );
        } else {
          Logger().warning(
            'Could not delete physical file: ${soundModel.filePath}',
            tag: 'REPOSITORY',
          );
        }
      }

      // Delete from database
      await localDataSource.deleteSound(id);
      Logger().info('Sound deleted from database: $id', tag: 'REPOSITORY');

      return const Right(null);
    } catch (e) {
      Logger().error('Failed to delete sound', tag: 'REPOSITORY', error: e);
      return Left(
        Failure.databaseFailure('Failed to delete sound: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, Sound>> updateSound(Sound sound) async {
    try {
      final soundModel = SoundModel.fromEntity(sound);
      final updatedModel = await localDataSource.updateSound(soundModel);
      return Right(updatedModel.toEntity());
    } catch (e) {
      return Left(
        Failure.databaseFailure('Failed to update sound: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, Sound>> getSoundById(int id) async {
    try {
      final soundModel = await localDataSource.getSoundById(id);
      if (soundModel == null) {
        return Left(Failure.validationFailure('Sound not found with id: $id'));
      }
      return Right(soundModel.toEntity());
    } catch (e) {
      return Left(
        Failure.databaseFailure('Failed to get sound: ${e.toString()}'),
      );
    }
  }
}
