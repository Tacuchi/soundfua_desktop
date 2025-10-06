import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:soundfua_desktop/core/error/failures.dart';
import 'package:soundfua_desktop/features/overlay/data/datasources/file/sound_file_datasource.dart';
import 'package:soundfua_desktop/features/overlay/data/datasources/local/app_database.dart';
import 'package:soundfua_desktop/features/overlay/data/datasources/local/sound_local_datasource.dart';
import 'package:soundfua_desktop/features/overlay/domain/entities/sound.dart';
import 'package:soundfua_desktop/features/overlay/domain/repositories/sound_repository.dart';

class SoundRepositoryImpl implements SoundRepository {
  final SoundLocalDataSource localDataSource;
  final SoundFileDataSource fileDataSource;
  final AppDatabase database;

  SoundRepositoryImpl({
    required this.localDataSource,
    required this.fileDataSource,
    required this.database,
  });

  @override
  Future<Either<Failure, List<Sound>>> getAllSounds() async {
    try {
      final models = await localDataSource.getAllSounds();
      final entities = models.map((m) => m.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(Failure.cache(message: 'Error al obtener sonidos: $e'));
    }
  }

  @override
  Future<Either<Failure, Sound>> getSoundById(int id) async {
    try {
      final model = await localDataSource.getSoundById(id);
      if (model == null) {
        return Left(
          Failure.cache(message: 'Sonido con ID $id no encontrado'),
        );
      }
      return Right(model.toEntity());
    } catch (e) {
      return Left(Failure.cache(message: 'Error al obtener sonido: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAllSounds() async {
    try {
      await localDataSource.deleteAllSounds();
      return const Right(null);
    } catch (e) {
      return Left(Failure.cache(message: 'Error al eliminar sonidos: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> syncFolder(String folderPath) async {
    try {
      final soundModels = await fileDataSource.readFolder(folderPath);

      await database.transaction(() async {
        await localDataSource.deleteAllSounds();

        if (soundModels.isNotEmpty) {
          await localDataSource.insertAll(soundModels);
        }

        await database.setSetting('library_path', folderPath);
      });

      return const Right(null);
    } on FileSystemException catch (e) {
      return Left(
        Failure.file(message: 'Error al leer carpeta: ${e.message}'),
      );
    } catch (e) {
      return Left(Failure.unknown(message: 'Error al sincronizar: $e'));
    }
  }
}
