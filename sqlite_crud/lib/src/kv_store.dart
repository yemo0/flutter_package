import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqlite_crud/src/conn.dart';

class KVStore {
  // db table name
  static const kvStore = 'kv_store';
  // create kv_store table
  static const createTableKVStore = '''CREATE TABLE $kvStore (
key TEXT PRIMARY KEY,
value TEXT
);
''';

  static Future<int> setKV(String key, String value) async {
    final db = await SqliteDBConn().getDB();
    final res = await db.insert(kvStore, {'key': key, 'value': value}, conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  static Future<String?> getKV(String key) async {
    final db = await SqliteDBConn().getDB();
    final res = await db.query(kvStore, where: "key = ?", whereArgs: [key]);
    if (res.isEmpty) return null;
    return res.first['value'] as String?;
  }
}
