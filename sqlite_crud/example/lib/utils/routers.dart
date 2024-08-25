import 'package:go_router/go_router.dart';

import '../home/home.dart';

final router = GoRouter(initialLocation: '/', routes: <GoRoute>[
  GoRoute(
    path: '/',
    name: 'home',
    builder: (context, state) => const HomeScreen(),
    routes: const <GoRoute>[
      // GoRoute(path: '/setting', name: 'setting', builder: (context, state) => const Sett()),
      // GoRoute(
      //     path: 'detail',
      //     name: 'detail',
      //     builder: (context, state) => const DetailScreen()),
    ],
  ),
]);
