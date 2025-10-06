import 'package:soundfua_desktop/features/overlay/data/datasources/local/app_database.dart';
import 'package:soundfua_desktop/features/overlay/data/models/sound_model.dart';

class SoundLocalDataSource {
  final AppDatabase database;

  SoundLocalDataSource(this.database);

  Future<List<SoundModel>> getAllSounds() async {
    final entries = await database.getAllSounds();
    return entries.map((e) => SoundModel.fromEntry(e)).toList();
  }

  Future<SoundModel?> getSoundById(int id) async {
    final entry = await database.getSoundById(id);
    return entry != null ? SoundModel.fromEntry(entry) : null;
  }

  Future<void> insertSound(SoundModel sound) async {
    await database.insertSound(sound.toCompanion());
  }

  Future<void> insertAll(List<SoundModel> sounds) async {
    final companions = sounds.map((s) => s.toCompanion()).toList();
    await database.insertAllSounds(companions);
  }

  Future<void> deleteAllSounds() async {
    await database.deleteAllSounds();
  }

  Stream<List<SoundModel>> watchAllSounds() {
    return database
        .watchAllSounds()
        .map((entries) => entries.map((e) => SoundModel.fromEntry(e)).toList());
  }

  Stream<int> watchSoundsCount() {
    return database.watchSoundsCount();
  }
}
