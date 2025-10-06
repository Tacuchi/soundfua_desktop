import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DataClassName('SoundEntry')
class Sounds extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get fileName => text()();
  TextColumn get filePath => text()();
  IntColumn get fileSize => integer()();
  DateTimeColumn get addedOn => dateTime()();
  DateTimeColumn get lastModified => dateTime()();
  IntColumn get playCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastPlayedAt => dateTime().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {filePath}
      ];
}

class Settings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text().nullable()();
  
  @override
  Set<Column> get primaryKey => {key};
}

@DriftDatabase(tables: [Sounds, Settings])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_sounds_file_name '
            'ON sounds(file_name)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_sounds_last_modified '
            'ON sounds(last_modified DESC)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_sounds_last_played_at '
            'ON sounds(last_played_at DESC)',
          );
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 2) {
            await customStatement('DROP TABLE IF EXISTS settings');
            await m.createTable(settings);
          }
        },
      );

  Future<List<SoundEntry>> getAllSounds() async {
    return await select(sounds).get();
  }

  Future<SoundEntry?> getSoundById(int id) async {
    return await (select(sounds)..where((s) => s.id.equals(id)))
        .getSingleOrNull();
  }

  Future<int> insertSound(SoundsCompanion sound) async {
    return await into(sounds).insert(sound);
  }

  Future<void> insertAllSounds(List<SoundsCompanion> soundList) async {
    await batch((batch) {
      batch.insertAll(sounds, soundList);
    });
  }

  Future<void> deleteAllSounds() async {
    await delete(sounds).go();
  }

  Stream<List<SoundEntry>> watchAllSounds() {
    return select(sounds).watch();
  }

  Stream<int> watchSoundsCount() {
    final countQuery = selectOnly(sounds)..addColumns([sounds.id.count()]);
    return countQuery
        .map((row) => row.read(sounds.id.count()) ?? 0)
        .watchSingle();
  }

  Future<String?> getSetting(String key) async {
    final result = await (select(settings)..where((s) => s.key.equals(key)))
        .getSingleOrNull();
    return result?.value;
  }

  Future<void> setSetting(String key, String value) async {
    await into(settings).insertOnConflictUpdate(
      SettingsCompanion(
        key: Value(key),
        value: Value(value),
      ),
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationSupportDirectory();
    final file = File(p.join(dbFolder.path, 'soundfua.db'));
    return NativeDatabase(file);
  });
}
