import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class SqlitePersistence {
  static const DatabaseName = 'aloompa.db';
  static const ArtistsTableName = 'artists';
  Database db;

  SqlitePersistence._(this.db);

  static Future<SqlitePersistence> create() async =>
      SqlitePersistence._(await database());


  static Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), DatabaseName),
      onCreate: (db, version) {
        return db.execute(
          '''CREATE TABLE $ArtistsTableName(
            id TEXT PRIMARY KEY,
            name STRING,
            description STRING,
            image STRING
          )''',
        );
      },
      version: 1,
    );
  }

  Future<List<Map<String, dynamic>>> getUniqueObjects() async {
    final ret = await db.rawQuery('SELECT * FROM $ArtistsTableName ');
    return ret;
  }

  Future<List<Map<String, dynamic>>> findObjects(String query) async {
    final ret = await db.rawQuery(
        'SELECT * FROM $ArtistsTableName ',
        ['%$query%']);

    return ret;
  }

  void createOrUpdateObject(String key, Map<String, dynamic> object) async {
    await db.insert(ArtistsTableName, object,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  void createOrUpdateBatchObject(List<Map<String, dynamic>> objects) async {
    /// Initialize batch
    final batch = db.batch();
    for (var item in objects) {
      batch.insert(ArtistsTableName, item,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    /// Commit
    await batch.commit(noResult: true);
  }

  Future<void> removeObject(String key) async {
    await db.delete(
      ArtistsTableName,
      where: 'id = ?',
      whereArgs: [key],
    );
  }
}
