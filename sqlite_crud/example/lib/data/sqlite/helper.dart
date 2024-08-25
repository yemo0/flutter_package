
import 'package:sqlite_crud/crud.dart';

import '../../../models/data_model.dart';
import 'config.dart';

class DBHelper {
  Future<int> insertData(DataModel data) async {
    return SqliteCRUD.insert(DBConfig.data, data);
  }

  Future<List<DataModel>> getDataNotDeleted() async {
    return SqliteCRUD.query(DBConfig.data, const DataModel(), where: "is_deleted = ?", whereArgs: [0], orderBy: "server_updated_at DESC");
  }

  Future<int> updateData(DataModel data) async {
    return SqliteCRUD.updateByUUID(DBConfig.data, data, data.uuid!);
  }
}
