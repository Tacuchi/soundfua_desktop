import 'package:drift/drift.dart';
import '../../models/sound_model.dart';
import 'app_database.dart';

/// Abstract interface for local sound data operations
abstract class SoundLocalDataSource {
  Future<List<SoundModel>> getAllSounds();
  Future<SoundModel> addSound(SoundModel sound);
  Future<void> deleteSound(int id);
  Future<SoundModel> updateSound(SoundModel sound);
  Future<SoundModel?> getSoundById(int id);
}

/// Implementation of SoundLocalDataSource using Drift database
class SoundLocalDataSourceImpl implements SoundLocalDataSource {
  final AppDatabase database;

  SoundLocalDataSourceImpl(this.database);

  @override
  Future<List<SoundModel>> getAllSounds() async {
    final soundsData = await database.getAllSounds();
    return soundsData.map((data) => _soundDataToModel(data)).toList();
  }

  @override
  Future<SoundModel> addSound(SoundModel sound) async {
    final soundData = SoundsTableCompanion(
      filePath: Value(sound.filePath),
      alias: Value(sound.alias),
      addedOn: Value(sound.addedOn),
    );

    final insertedId = await database
        .into(database.soundsTable)
        .insert(soundData);
    final insertedData = await database.getSoundById(insertedId);
    return _soundDataToModel(insertedData!);
  }

  @override
  Future<void> deleteSound(int id) async {
    await database.deleteSound(id);
  }

  @override
  Future<SoundModel> updateSound(SoundModel sound) async {
    if (sound.id == null) {
      throw Exception('Cannot update sound without ID');
    }

    final soundData = SoundsTableData(
      id: sound.id!,
      filePath: sound.filePath,
      alias: sound.alias,
      addedOn: sound.addedOn,
    );

    final updatedData = await database.updateSound(soundData);
    return _soundDataToModel(updatedData);
  }

  @override
  Future<SoundModel?> getSoundById(int id) async {
    final soundData = await database.getSoundById(id);
    return soundData != null ? _soundDataToModel(soundData) : null;
  }

  /// Convert SoundsTableData to SoundModel
  SoundModel _soundDataToModel(SoundsTableData data) {
    return SoundModel(
      id: data.id,
      filePath: data.filePath,
      alias: data.alias,
      addedOn: data.addedOn,
    );
  }
}
