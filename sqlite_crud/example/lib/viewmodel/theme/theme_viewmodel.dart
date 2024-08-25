import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../theme/dark_theme.dart';
import '../../theme/light_theme.dart';


part 'theme_viewmodel.g.dart';

@riverpod
class ThemeViewModel extends _$ThemeViewModel {
  @override
  ThemeData build() {
    return lightMode;
  }

  void toggleTheme() {
    state = state == lightMode ? darkMode : lightMode;
  }
}