import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theme_provider/theme_provider.dart';

class DarkModeButton extends ConsumerWidget {
  const DarkModeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final themeNotifier = ref.read(themeProvider.notifier);
    return IconButton(
      onPressed: themeNotifier.toggleTheme,
      icon: Icon(themeState == ThemeMode.light ? Icons.sunny : Icons.dark_mode),
    );
  }
}
