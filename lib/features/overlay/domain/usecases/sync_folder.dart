import 'package:dartz/dartz.dart';
import 'package:soundfua_desktop/core/error/failures.dart';
import 'package:soundfua_desktop/core/usecases/usecase.dart';
import 'package:soundfua_desktop/features/overlay/domain/repositories/sound_repository.dart';

class SyncFolderParams {
  final String folderPath;

  const SyncFolderParams(this.folderPath);
}

class SyncFolderUseCase implements UseCase<void, SyncFolderParams> {
  final SoundRepository repository;

  SyncFolderUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(SyncFolderParams params) async {
    return await repository.syncFolder(params.folderPath);
  }
}
