// syncLastTime server->client
import 'dart:convert';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqlite_crud/sqlite_crud.dart';

abstract class SqliteSyncModel<T> implements SqliteCRUDModel {
  String? get uuid;
  DateTime? get updatedAt;
  DateTime? get createdAt;
  int? get serverUpdated;
  bool? get isDeleted;
  bool? get isSynced;

  get copyWith;
}

class SqliteSyncData<T extends SqliteSyncModel2> {
  T t;
  SqliteSyncData(this.t);

  // checkSyncUpdate
  Future<bool> checkSyncUpdate(String tableName) async {
    final db = await SqliteDBConn().getDB();
    final res = await db.query(tableName, where: "is_synced = ?", columns: ["uuid"], whereArgs: [0]);
    return res.isNotEmpty;
  }

  // syncData server <- client
  Future<bool> syncData(String tableName, String syncDataUrl, Function(String url, Object? data) post) async {
    final db = await SqliteDBConn().getDB();

    // Get the last sync time
    final lastSyncTime = await KVStore.getKV("last_sync_time");

    // Get server data
    final res = await post(syncDataUrl, {"server_updated": int.parse(lastSyncTime ?? "0")});
    if (res == null) {
      return false;
    }

    final data = res['data'] as List;
    print('data count: ${data.length}');

    List<T> items = List.generate(data.length, (index) => t.fromJson(data[index]) as T);
    if (items.isEmpty) return false;

    // Get query uuid
    String uuidListString = getDataUUID(items);

    // Update local data
    final List<Map<String, dynamic>> localData =
        await db.rawQuery("SELECT * FROM $tableName WHERE uuid IN ($uuidListString)");
    final List<T> localDataList =
        List.generate(localData.length, (index) => t.fromJson(ModelConvert.sqliteToModel(localData[index])) as T);
    for (var e in items) {
      final creentData = localDataList.firstWhere((element) => element.uuid == e.uuid, orElse: () => t);
      if (creentData.uuid != null) {
        // Update local database
        var res = ModelConvert.modelToSqlite(e.toJson());
        res["is_synced"] = 1;
        if (!creentData.updatedAt!.isAfter(e.updatedAt!)) {
          await db.update(tableName, res, where: "uuid = ?", whereArgs: [e.uuid]);
          continue;
        }
      } else {
        // Can't find in local database create
        var res = ModelConvert.modelToSqlite(e.toJson());
        res["is_synced"] = 1;
        await db.insert(tableName, res);
      }
    }
    saveLastSyncTime(items);
    return true;
  }

  // syncUpdate client -> server
  Future<bool> syncUpdate(String syncUpdateUrl, String tableName, Function(String url, Object? data) post) async {
    final db = await SqliteDBConn().getDB();
    List<T> queryData = await SqliteCRUD.query(tableName, t,
        where: "is_synced = ?", whereArgs: [0], orderBy: "updated_at ASC", limit: 20);
    final res = await post(syncUpdateUrl, jsonEncode(queryData));

    // Update local data
    if (res == null) return false;
    final data = res['data'] as List;
    if (data.isEmpty) return false;

    List<T> items = List.generate(data.length, (index) => t.fromJson(ModelConvert.sqliteToModel(data[index])) as T);

    // Update is_synced = true
    String uuidListString = getDataUUID(items);
    await db.rawUpdate("UPDATE $tableName SET is_synced = 1 WHERE uuid IN ($uuidListString)");
    return true;
  }

  // svae last sync time
  void saveLastSyncTime(List<T> data) {
    final lastServerUpdated = data.last.serverUpdated?.toString() ?? "";
    KVStore.setKV("last_sync_time", lastServerUpdated);
  }

  String getDataUUID(List<T> items) {
    String uuidListString = "";
    for (var e in items) {
      uuidListString += e.uuid != null ? '"${e.uuid}", ' : "";
    }
    if (uuidListString.endsWith(", ")) {
      uuidListString = uuidListString.substring(0, uuidListString.length - 2);
    }
    return uuidListString;
  }
}

class SyncOption {
<<<<<<< HEAD
  static T insert<T extends SqliteSyncModel>(T t) {
    return t.copyWith(uuid: const Uuid().v7(), updatedAt: DateTime.now(), isSynced: false, createdAt: DateTime.now());
  }

  static T delete<T extends SqliteSyncModel>(T t) {
    return t.copyWith(updatedAt: DateTime.now(), isSynced: false, isDeleted: true);
  }

  static T update<T extends SqliteSyncModel>(T t) {
=======
  static T insert<T extends SqliteSyncModel2>(T t) {
    return t.copyWith(uuid: const Uuid().v7(), updatedAt: DateTime.now(), isSynced: false, createdAt: DateTime.now());
  }

  static T delete<T extends SqliteSyncModel2>(T t) {
    return t.copyWith(updatedAt: DateTime.now(), isSynced: false, isDeleted: true);
  }

  static T update<T extends SqliteSyncModel2>(T t) {
>>>>>>> ae0a301139d7307a660458cc8e995d72b8d9ed22
    return t.copyWith(updatedAt: DateTime.now(), isSynced: false);
  }
}
