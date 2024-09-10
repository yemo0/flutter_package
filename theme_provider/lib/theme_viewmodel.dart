import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = NotifierProvider.autoDispose<ThemeNotifier, ThemeMode>(ThemeNotifier.new);

class ThemeNotifier extends AutoDisposeNotifier<ThemeMode> {
  @override
  ThemeMode build() {
    return ThemeMode.light;
  }

  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }

  void changeTheme(ThemeMode theme) {
    state = theme;
  }
}