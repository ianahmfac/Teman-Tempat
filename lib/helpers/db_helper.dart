import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future insert(String table, Map<String, Object> data) async {
    final String dbPath = await getDatabasesPath();
    final String createTabelQuery = """
    CREATE TABLE USER_PLACES(
      id TEXT PRIMARY KEY,
      title TEXT,
      image TEXT
    )
    """;
    final Database db = await openDatabase(
      join(dbPath, "places.db"),
      onCreate: (db, version) {
        return db.execute(createTabelQuery);
      },
      version: 1,
    );

    await db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
