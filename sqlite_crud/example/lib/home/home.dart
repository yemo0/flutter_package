import 'package:example/home/home_list.dart';
import 'package:example/theme/dark_theme.dart';
import 'package:example/viewmodel/theme/theme_viewmodel.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeViewModelProvider);
    final themeNotifier = ref.read(themeViewModelProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: themeNotifier.toggleTheme,
            icon: Icon(themeState == darkMode
                ? Icons.sunny
                : FontAwesomeIcons.solidMoon),
          ),
        ],
      ),
      body: const HomeList(),
    );
  }
}
