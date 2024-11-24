import 'package:example/data/sqlite/helper.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqlite_crud/sqlite_crud.dart';

import '../../models/data_model.dart';

part 'home_list_viewmodel.g.dart';

TextEditingController idController = TextEditingController();
TextEditingController contentController = TextEditingController();

@riverpod
class HomeListViewModel extends _$HomeListViewModel {
  @override
  List<DataModel> build() {
    return <DataModel>[];
  }

  void getData() async {
    DBHelper helper = DBHelper();
    final res = await helper.getDataNotDeleted();
    state = res;
  }

  void addData({required String uuid, content}) async {
    var data = SyncOption<DataModel>().insert(DataModel(uuid: uuid, content: content));
    DBHelper helper = DBHelper();
    final res = await helper.insertData(data);
    if (res != -1) {
      getData();
    }
  }

  void deleteData(String uuid, content) async {
    var data = SyncOption<DataModel>().delete(DataModel(uuid: uuid, content: content));
    DBHelper helper = DBHelper();
    final res = await helper.updateData(data);
    if (res != 0) {
      getData();
    }
  }

  void updateData({required String uuid, content}) async {
    var data = SyncOption<DataModel>().update(DataModel(uuid: uuid, content: content));
    DBHelper helper = DBHelper();
    final res = await helper.updateData(data);
    if (res != 0) {
      getData();
    }
  }

  Future<int> syncedCount() async {
    DBHelper helper = DBHelper();
    return await helper.getSyncedCount();
  }
}
