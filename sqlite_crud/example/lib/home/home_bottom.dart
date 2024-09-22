import 'package:example/data/sqlite/config.dart';
import 'package:example/models/data_model.dart';
import 'package:example/utils/config.dart';
import 'package:example/utils/extension.dart';
import 'package:example/utils/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqlite_crud/sqlite_crud.dart';
import 'package:uuid/uuid.dart';

import '../viewmodel/home/home_list_viewmodel.dart';

class HomeBottom extends ConsumerStatefulWidget {
  const HomeBottom({super.key});

  @override
  HomeBottomState createState() => HomeBottomState();
}

class HomeBottomState extends ConsumerState<HomeBottom> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      sync();
      ref.read(homeListViewModelProvider.notifier).getData();
    });
  }

  void sync() async {
    for (; true;) {
      bool res = await SqliteSyncData<DataModel>(const DataModel())
          .syncLastTime(DBConfig.data, Config.syncLastTimeUrl, Http.https.post);
      if (res) {
        ref.read(homeListViewModelProvider.notifier).getData();
      }
      await SqliteSyncData<DataModel>(const DataModel())
          .syncUpdate(Config.syncUpdateUrl, DBConfig.data, Http.https.post);
      await Future.delayed(const Duration(seconds: 5));
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeListNotif = ref.read(homeListViewModelProvider.notifier);

    return SizedBox(
      // height: 200,
      width: context.screenWidth,
      // color: Colors.amber,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                height: 50,
                width: context.screenWidth * 0.5,
                child: TextField(
                  controller: idController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "ID",
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: context.screenWidth * 0.5,
                child: TextField(
                  controller: contentController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Content",
                  ),
                ),
              )
            ],
          ),
          Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    homeListNotif.deleteData(idController.text, contentController.text);
                  },
                  child: const Text("delete")),
              ElevatedButton(
                onPressed: () {
                  homeListNotif.addData(uuid: const Uuid().v4(), content: contentController.text);
                },
                child: const Text("add"),
              ),
              ElevatedButton(
                  onPressed: () {
                    homeListNotif.updateData(uuid: idController.text, content: contentController.text);
                  },
                  child: const Text("update")),
            ],
          )
        ],
      ),
    );
  }
}
