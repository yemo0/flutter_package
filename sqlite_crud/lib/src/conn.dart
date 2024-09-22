import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqlite_crud/src/kv_store.dart';

class SqliteDBConn {
  static final SqliteDBConn _instance = SqliteDBConn._internal();
  static Database? _database;
  SqliteDBConn._internal();

  factory SqliteDBConn() {
    return _instance;
  }

  Future<void> init(String dbPathName, List<String> createTableSql, {int version = 1, bool needKVStore = true}) async {
    if (_database != null) return;
    _database = await _initDatabase(dbPathName, createTableSql, version: version, needKVStore: needKVStore);
  }

  Future<Database> getDB() async {
    if (_database == null) {
      throw Exception("Database not initialized");
    }
    return _database!;
  }

  Future<Database> _initDatabase(String dbPathName, List createTableSql,
      {int version = 1, bool needKVStore = true}) async {
    // desktop
    if (Platform.isWindows || Platform.isLinux) {
      // Initialize FFI
      sqfliteFfiInit();
      // Change the default factory
      databaseFactory = databaseFactoryFfi;
    }

    return openDatabase(
      join(await getDatabasesPath(), dbPathName),
      onCreate: (db, version) async {
        // create table
        for (var sql in createTableSql) {
          await db.execute(sql);
        }
        // need create kvstore table
        if (needKVStore) {
          await db.execute(KVStore.createTableKVStore);
        }
        return;
      },
      version: version,
    );
  }
}
