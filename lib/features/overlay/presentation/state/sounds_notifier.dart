import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soundfua_desktop/core/usecases/usecase.dart';
import 'package:soundfua_desktop/features/overlay/domain/usecases/get_all_sounds.dart';
import 'package:soundfua_desktop/features/overlay/domain/usecases/sync_folder.dart';
import 'package:soundfua_desktop/features/overlay/presentation/state/sounds_state.dart';

class SoundsNotifier extends StateNotifier<SoundsState> {
  final GetAllSoundsUseCase getAllSoundsUseCase;
  final SyncFolderUseCase syncFolderUseCase;

  SoundsNotifier({
    required this.getAllSoundsUseCase,
    required this.syncFolderUseCase,
  }) : super(const SoundsState.initial());

  Future<void> loadSounds() async {
    state = const SoundsState.loading();

    final result = await getAllSoundsUseCase(const NoParams());

    result.fold(
      (failure) => state = SoundsState.error(failure.message),
      (sounds) => state = SoundsState.loaded(
        sounds: sounds,
        count: sounds.length,
      ),
    );
  }

  Future<void> syncFolder(String folderPath) async {
    state = const SoundsState.syncing();

    final result = await syncFolderUseCase(SyncFolderParams(folderPath));

    result.fold(
      (failure) => state = SoundsState.error(failure.message),
      (_) async {
        await loadSounds();
      },
    );
  }
}
