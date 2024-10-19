import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqlite_crud/src/kv_store.dart';

class CreateTableModel {
  final String tableName;
  final String createTableSql;
  CreateTableModel(this.tableName, this.createTableSql);
}

class SqliteDBConn {
  static final SqliteDBConn _instance = SqliteDBConn._internal();
  static Database? _database;
  SqliteDBConn._internal();

  factory SqliteDBConn() {
    return _instance;
  }

  Future<void> init(String dbPathName, List<CreateTableModel> createTables,
      {int version = 1, bool needKVStore = true}) async {
    if (_database != null) return;
    _database = await _initDatabase(dbPathName, createTables, version: version, needKVStore: needKVStore);
  }

  Future<Database> getDB() async {
    if (_database == null) {
      throw Exception("Database not initialized");
    }
    return _database!;
  }

  Future<Database> _initDatabase(String dbPathName, List<CreateTableModel> createTables,
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
        for (var e in createTables) {
          await db.execute(e.createTableSql);
        }
        // need create kvstore table
        if (needKVStore) {
          await db.execute(KVStore.createTableKVStore);
        }
        return;
      },
      // onOpen: (db) async {
      //   // If the table does not exist
      //   for (var e in createTables) {
      //     if (await isTableExists(db, e.tableName)) {
      //       await db.execute(e.createTableSql);
      //     }
      //   }
      // },
      version: version,
    );
  }

  Future<bool> isTableExists(Database db, String tableName) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table' AND name=?", [tableName]);
    return result.isNotEmpty;
  }
}
