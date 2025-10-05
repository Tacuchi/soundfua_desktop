import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Domain layer - Sound Library
import '../../features/sound_library/domain/repositories/sound_repository.dart';
import '../../features/sound_library/domain/usecases/get_all_sounds.dart';
import '../../features/sound_library/domain/usecases/add_sound.dart';
import '../../features/sound_library/domain/usecases/delete_sound.dart';

// Data layer - Sound Library
import '../../features/sound_library/data/repositories/sound_repository_impl.dart';
import '../../features/sound_library/data/datasources/local/sound_local_data_source.dart';
import '../../features/sound_library/data/datasources/file/sound_file_data_source.dart';
import '../../features/sound_library/data/datasources/local/app_database.dart';

// Domain layer - Settings
import '../../features/settings/domain/repositories/settings_repository.dart';
import '../../features/settings/domain/usecases/get_theme_mode_setting.dart';
import '../../features/settings/domain/usecases/save_theme_mode_setting.dart';

// Data layer - Settings
import '../../features/settings/data/repositories/settings_database_repository_impl.dart';
import '../../features/settings/data/datasources/local/settings_local_data_source.dart';
import '../../features/settings/data/datasources/local/settings_database_data_source.dart';

// Audio Device Services
import '../../features/settings/domain/services/audio_device_service.dart';
import '../../features/sound_library/domain/services/multi_audio_service.dart';

// Data Sources Providers
final soundFileDataSourceProvider = Provider<SoundFileDataSource>((ref) {
  return SoundFileDataSourceImpl();
});

final soundLocalDataSourceProvider = Provider<SoundLocalDataSource>((ref) {
  return SoundLocalDataSourceImpl(ref.read(appDatabaseProvider));
});

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return database;
});

// Repository Provider
final soundRepositoryProvider = Provider<SoundRepository>((ref) {
  return SoundRepositoryImpl(
    localDataSource: ref.read(soundLocalDataSourceProvider),
    fileDataSource: ref.read(soundFileDataSourceProvider),
  );
});

// Use Cases Providers
final getAllSoundsProvider = Provider<GetAllSounds>((ref) {
  return GetAllSounds(ref.read(soundRepositoryProvider));
});

final addSoundProvider = Provider<AddSound>((ref) {
  return AddSound(ref.read(soundRepositoryProvider));
});

final deleteSoundProvider = Provider<DeleteSound>((ref) {
  return DeleteSound(ref.read(soundRepositoryProvider));
});

// === SETTINGS FEATURE ===

// Shared Preferences Provider
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be initialized in main()');
});

// Settings Data Sources Providers
final settingsLocalDataSourceProvider = Provider<SettingsLocalDataSource>((
  ref,
) {
  return SettingsLocalDataSourceImpl(ref.read(sharedPreferencesProvider));
});

final settingsDatabaseDataSourceProvider = Provider<SettingsDatabaseDataSource>(
  (ref) {
    return SettingsDatabaseDataSource(ref.read(appDatabaseProvider));
  },
);

// Settings Repository Provider (using database)
final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsDatabaseRepositoryImpl(
    databaseDataSource: ref.read(settingsDatabaseDataSourceProvider),
    sharedPreferences: ref.read(sharedPreferencesProvider),
  );
});

// Settings Use Cases Providers
final getThemeModeSettingProvider = Provider<GetThemeModeSetting>((ref) {
  return GetThemeModeSetting(ref.read(settingsRepositoryProvider));
});

final saveThemeModeSettingProvider = Provider<SaveThemeModeSetting>((ref) {
  return SaveThemeModeSetting(ref.read(settingsRepositoryProvider));
});

// === AUDIO DEVICE FEATURE ===

// Audio Device Service Provider
final audioDeviceServiceProvider = Provider<AudioDeviceService>((ref) {
  return AudioDeviceService();
});

// Multi Audio Service Provider (singleton)
final multiAudioServiceProvider = Provider<MultiAudioService>((ref) {
  return MultiAudioService();
});
