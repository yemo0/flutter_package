// 2024-08-07 03:05:22
import 'package:sqlite_crud/conn.dart';

abstract class SqliteCRUDModel {
  Map<String, dynamic> toJson();
  SqliteCRUDModel fromJson(Map<String, dynamic> json);
}

class SqliteCRUD {
  static Future<int> insert<T extends SqliteCRUDModel>(String tableName, T t) async {
    final db = await SqliteDBConn().getDB();
    final res = await db.insert(tableName, ModelConvert.modelToSqlite(t.toJson()));
    return res;
  }

  static Future<int> insertByConvert<T extends SqliteCRUDModel>(
      String tableName, T t, Function(Map<String, dynamic>) fn) async {
    final db = await SqliteDBConn().getDB();
    final res = await db.insert(tableName, fn(ModelConvert.modelToSqlite(t.toJson())));
    return res;
  }

  static Future<int> deleteByID<T extends SqliteCRUDModel>(String tableName, int id) async {
    final db = await SqliteDBConn().getDB();
    final res = await db.delete(tableName, where: "id = ?", whereArgs: [id]);
    return res;
  }

  static Future<int> deleteByUUID<T extends SqliteCRUDModel>(String tableName, String uuid) async {
    final db = await SqliteDBConn().getDB();
    final res = await db.delete(tableName, where: "id = ?", whereArgs: [uuid]);
    return res;
  }

  static Future<int> updateByIDorUUID<T extends SqliteCRUDModel>(String tableName, T t, int id) async {
    final db = await SqliteDBConn().getDB();
    // remove id
    final json = t.toJson();
    json.remove("id");
    final res = await db.update(tableName, ModelConvert.modelToSqlite(json), where: "id = ?", whereArgs: [id]);
    return res;
  }

  static Future<int> updateByUUID<T extends SqliteCRUDModel>(String tableName, T t, String uuid) async {
    final db = await SqliteDBConn().getDB();
    // remove uuid
    final json = t.toJson();
    json.remove("uuid");
    final res = await db.update(tableName, ModelConvert.modelToSqlite(t.toJson()), where: "uuid = ?", whereArgs: [uuid]);
    return res;
  }

  static Future<List<T>> query<T extends SqliteCRUDModel>(String tableName, T t,
      {bool? distinct,
      List<String>? columns,
      String? where,
      List<Object?>? whereArgs,
      String? groupBy,
      String? having,
      String? orderBy,
      int? limit,
      int? offset,
      Map<String, dynamic> Function(Map<String, dynamic>)? convertFn}) async {
    final db = await SqliteDBConn().getDB();
    final List<Map<String, dynamic>> maps = await db.query(tableName,
        distinct: distinct,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        groupBy: groupBy,
        having: having,
        orderBy: orderBy,
        limit: limit,
        offset: offset);

    if (convertFn != null) {
      return List.generate(maps.length, (index) => t.fromJson(convertFn(ModelConvert.sqliteToModel(maps[index]))) as T);
    }
    return List.generate(maps.length, (index) => t.fromJson(ModelConvert.sqliteToModel(maps[index])) as T);
  }
}

// sqlite type conversion
class ModelConvert {
  static Map<String, dynamic> modelToSqlite(Map<String, dynamic> data) {
    final map = <String, dynamic>{};
    data.forEach((key, value) {
      if (value == null) return;
      if (key.startsWith("is")) {
        map[key] = value == true ? 1 : 0;
        return;
      }
      if (key.endsWith("At") || key.endsWith("at")) {
        map[key] = DateTime.parse(value).toUtc().toIso8601String();
        return;
      }
      map[key] = value;
    });
    return map;
  }

  static Map<String, dynamic> sqliteToModel(Map<String, dynamic> data) {

    final map = <String, dynamic>{};
    data.forEach((key, value) {
      if (value == null) return;
      if (key.startsWith("is")) {
        map[key] = value == 1;
        return;
      }
      // if (key.endsWith("At") || key.endsWith("at")) {
      //   map[key] = value;
      //   return;
      // }
      map[key] = value;
    });
    return map;
  }
}
