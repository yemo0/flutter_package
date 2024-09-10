import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color.fromRGBO(18, 18, 18, 1),
  colorScheme: const ColorScheme.dark(
    surface: Color.fromRGBO(35, 35, 35, 1),
    // primary: Colors.blueAccent,
    // secondary: Colors.blue,
    // onSecondary: Colors.white,
    // tertiary: Colors.yellow,
  ),
  // disable appbar color change on scroll
  appBarTheme: const AppBarTheme(
    scrolledUnderElevation: 0.0,
  )
);

ThemeData darkModeCool = darkMode.copyWith();
