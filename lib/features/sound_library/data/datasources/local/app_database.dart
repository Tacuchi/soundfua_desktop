import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

/// Sounds table definition
class SoundsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get filePath => text()();
  TextColumn get alias => text()();
  DateTimeColumn get addedOn => dateTime()();

  @override
  String get tableName => 'sounds';
}

/// Settings table definition for app configuration
class SettingsTable extends Table {
  TextColumn get key => text().withLength(min: 1, max: 255)();
  TextColumn get value => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  String get tableName => 'settings';

  @override
  Set<Column> get primaryKey => {key};
}

/// Main application database
@DriftDatabase(tables: [SoundsTable, SettingsTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 2;

  /// Get all sounds ordered by most recent first
  Future<List<SoundsTableData>> getAllSounds() => (select(
    soundsTable,
  )..orderBy([(t) => OrderingTerm.desc(t.addedOn)])).get();

  /// Add a new sound
  Future<int> addSound(SoundsTableCompanion sound) async {
    return await into(soundsTable).insert(sound);
  }

  /// Delete a sound by ID
  Future<void> deleteSound(int id) async {
    await (delete(soundsTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  /// Update a sound
  Future<SoundsTableData> updateSound(SoundsTableData sound) async {
    await update(soundsTable).replace(sound);
    return sound;
  }

  /// Get a sound by ID
  Future<SoundsTableData?> getSoundById(int id) async {
    return await (select(
      soundsTable,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  // ====== SETTINGS METHODS ======

  /// Get a setting value by key
  Future<String?> getSettingValue(String key) async {
    final result = await (select(
      settingsTable,
    )..where((tbl) => tbl.key.equals(key))).getSingleOrNull();
    return result?.value;
  }

  /// Save a setting
  Future<void> saveSetting(String key, String value) async {
    await into(settingsTable).insertOnConflictUpdate(
      SettingsTableCompanion(
        key: Value(key),
        value: Value(value),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Get all settings
  Future<Map<String, String>> getAllSettings() async {
    final results = await select(settingsTable).get();
    return Map.fromEntries(
      results.map((setting) => MapEntry(setting.key, setting.value)),
    );
  }

  /// Delete a setting
  Future<void> deleteSetting(String key) async {
    await (delete(settingsTable)..where((tbl) => tbl.key.equals(key))).go();
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // Create settings table when upgrading to version 2
          await m.createTable(settingsTable);
        }
      },
    );
  }
}

/// Database connection helper
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    // Put the database file in the documents directory.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'soundfua.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}

/// Global database instance
final database = AppDatabase(_openConnection());
