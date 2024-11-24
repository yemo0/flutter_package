import 'package:sqlite_crud/sqlite_crud.dart';

import '../../../models/data_model.dart';
import 'config.dart';

class DBHelper {
  Future<int> insertData(DataModel data) async {
    return SqliteCRUD.insert(DBConfig.data, data);
  }

  Future<List<DataModel>> getDataNotDeleted() async {
    return SqliteCRUD.query(DBConfig.data, const DataModel(),
        where: "is_deleted = ?", whereArgs: [0], orderBy: "u_at DESC");
  }

  Future<int> updateData(DataModel data) async {
    return SqliteCRUD.updateByUUID(DBConfig.data, data, data.uuid!);
  }

  Future<int> getSyncedCount() async {
    return SqliteCRUD.query(DBConfig.data, const DataModel(), where: "is_synced = ?", whereArgs: [1])
        .then((value) => value.length);
  }
}
