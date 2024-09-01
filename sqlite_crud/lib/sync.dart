// syncLastTime server->client
import 'dart:convert';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqlite_crud/kv_store.dart';
import 'package:sqlite_crud/sqlite_crud.dart';

abstract class SqliteSyncModel<T> implements SqliteCRUDModel {
  String? get uuid;
  DateTime? get updatedAt;
  DateTime? get createdAt;
  DateTime? get serverUpdatedAt;
  bool? get isDeleted;
  bool? get isSynced;

  get copyWith;
}

class SqliteSyncData<T extends SqliteSyncModel> {
  T t;
  SqliteSyncData(this.t);

  // 按照时间同步 server to client
  Future<bool> syncLastTime(String tableName, String syncLastTimeUrl, Function(String url, Object? data) post) async {
    final lastSyncTime = await KVStore.getKV("last_sync_time");
    Object? postData;

    // 判断是否第一次同步
    lastSyncTime == null ? postData = {} : postData = {'server_updated_at': lastSyncTime};
    final res = await post(syncLastTimeUrl, postData);

    final data = res['data'] as List;
    List<T> items = List.generate(data.length, (index) => t.fromJson(data[index]) as T);

    if (items.isEmpty) return false;
    return await syncLastTimeHelper(tableName, items);
  }

  Future<bool> syncLastTimeHelper(String tableName, List<T> data) async {
    final db = await SqliteDBConn().getDB();
    final batch = db.batch();

    // 使用server LastTime数据查询是否需要更新
    String uuidListString = "";
    for (var e in data) {
      uuidListString += e.uuid != null ? '"${e.uuid}", ' : "";
    }
    if (uuidListString.endsWith(", ")) {
      uuidListString = uuidListString.substring(0, uuidListString.length - 2);
    }

    // 使用server数据和client数据进行对比判断是否需要更新
    final List<Map<String, dynamic>> localData =
        await db.rawQuery("SELECT * FROM $tableName WHERE uuid IN ($uuidListString)");
    final List<T> localDataList = List.generate(localData.length, (index) =>t.fromJson( ModelConvert.sqliteToModel(localData[index])) as T);

    for (var e in data) {
      final creentData = localDataList.firstWhere((element) => element.uuid == e.uuid, orElse: () => t);
      if (creentData.uuid != null) {
        if (creentData.updatedAt!.isAfter(e.updatedAt!)) continue;
      }
      batch.insert(
        tableName,
        ModelConvert.modelToSqlite(e.toJson()),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);

    saveLastSyncTime(data);
    return Future.value(true);
  }

  // client to server
  Future syncUpdate(String syncUpdateUrl, String tableName, Function(String url, Object? data) post) async {
    final db = await SqliteDBConn().getDB();
    List<T> queryData = await SqliteCRUD.query(tableName, t,
        where: "is_synced = ?", whereArgs: [0], orderBy: "updated_at ASC", limit: 20);
    final res = await post(syncUpdateUrl, jsonEncode(queryData));

    // 使用server返回的数据 更新本地
    final data = res['data'] as List;
    if (data.isEmpty) return;

    List<T> items = List.generate(data.length, (index) => t.fromJson(ModelConvert.sqliteToModel(data[index])) as T);
    final batch = db.batch();
    for (var element in items) {
      batch.update(tableName, {"is_synced": 1}, where: "uuid = ?", whereArgs: [element.uuid]);
    }
    batch.commit();
    Future.value();
  }

  void saveLastSyncTime(List<T> data) {
    final lastServerUpdatedAt = data.last.serverUpdatedAt?.toUtc().toIso8601String() ?? "";
    KVStore.setKV("last_sync_time", lastServerUpdatedAt);
  }
}

class SyncOption<T extends SqliteSyncModel> {
  T insert(T t) {
    return t.copyWith(updatedAt: DateTime.now(), isSynced: false, createdAt: DateTime.now());
  }

  T delete(T t) {
    return t.copyWith(updatedAt: DateTime.now(), isSynced: false, isDeleted: true);
  }

  T update(T t) {
    return t.copyWith(updatedAt: DateTime.now(), isSynced: false);
  }
}
