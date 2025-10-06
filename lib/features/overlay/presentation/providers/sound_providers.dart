import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soundfua_desktop/features/overlay/data/datasources/file/sound_file_datasource.dart';
import 'package:soundfua_desktop/features/overlay/data/datasources/local/app_database.dart';
import 'package:soundfua_desktop/features/overlay/data/datasources/local/sound_local_datasource.dart';
import 'package:soundfua_desktop/features/overlay/data/repositories/sound_repository_impl.dart';
import 'package:soundfua_desktop/features/overlay/domain/repositories/sound_repository.dart';
import 'package:soundfua_desktop/features/overlay/domain/usecases/get_all_sounds.dart';
import 'package:soundfua_desktop/features/overlay/domain/usecases/get_sound_by_id.dart';
import 'package:soundfua_desktop/features/overlay/domain/usecases/sync_folder.dart';
import 'package:soundfua_desktop/features/overlay/presentation/state/sounds_notifier.dart';
import 'package:soundfua_desktop/features/overlay/presentation/state/sounds_state.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final soundLocalDataSourceProvider = Provider<SoundLocalDataSource>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return SoundLocalDataSource(database);
});

final soundFileDataSourceProvider = Provider<SoundFileDataSource>((ref) {
  return SoundFileDataSource();
});

final soundRepositoryProvider = Provider<SoundRepository>((ref) {
  final localDataSource = ref.watch(soundLocalDataSourceProvider);
  final fileDataSource = ref.watch(soundFileDataSourceProvider);
  final database = ref.watch(appDatabaseProvider);

  return SoundRepositoryImpl(
    localDataSource: localDataSource,
    fileDataSource: fileDataSource,
    database: database,
  );
});

final getAllSoundsUseCaseProvider = Provider<GetAllSoundsUseCase>((ref) {
  final repository = ref.watch(soundRepositoryProvider);
  return GetAllSoundsUseCase(repository);
});

final getSoundByIdUseCaseProvider = Provider<GetSoundByIdUseCase>((ref) {
  final repository = ref.watch(soundRepositoryProvider);
  return GetSoundByIdUseCase(repository);
});

final syncFolderUseCaseProvider = Provider<SyncFolderUseCase>((ref) {
  final repository = ref.watch(soundRepositoryProvider);
  return SyncFolderUseCase(repository);
});

final selectedFolderPathProvider = StateNotifierProvider<SelectedFolderNotifier, String?>((ref) {
  return SelectedFolderNotifier();
});

class SelectedFolderNotifier extends StateNotifier<String?> {
  SelectedFolderNotifier() : super(null) {
    _loadSavedFolder();
  }

  Future<void> _loadSavedFolder() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPath = prefs.getString('library_folder_path');
    if (savedPath != null) {
      state = savedPath;
    }
  }

  Future<void> setFolder(String path) async {
    state = path;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('library_folder_path', path);
  }
}

final soundsCountProvider = StreamProvider<int>((ref) {
  final localDataSource = ref.watch(soundLocalDataSourceProvider);
  return localDataSource.watchSoundsCount();
});

final soundsNotifierProvider =
    StateNotifierProvider<SoundsNotifier, SoundsState>((ref) {
  final getAllSoundsUseCase = ref.watch(getAllSoundsUseCaseProvider);
  final syncFolderUseCase = ref.watch(syncFolderUseCaseProvider);
  return SoundsNotifier(
    getAllSoundsUseCase: getAllSoundsUseCase,
    syncFolderUseCase: syncFolderUseCase,
  );
});
