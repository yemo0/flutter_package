
import 'package:example/data/sqlite/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqlite_crud/conn.dart';

import 'utils/routers.dart';
import 'viewmodel/theme/theme_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqliteDBConn().init("demo.db", [DBConfig.createTableSqlData]);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ref.watch(themeViewModelProvider),
      routerConfig: router,
    );
  }
}

