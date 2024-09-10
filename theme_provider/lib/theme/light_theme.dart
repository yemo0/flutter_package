import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color.fromRGBO(247, 247, 245, 1),
  colorScheme: const ColorScheme.light(
    surface: Colors.white,
    // primary: Colors.blueAccent,
    // secondary: Colors.blue,
    // onSecondary: Color.fromRGBO(255, 255, 255, 1),
    // tertiary: Colors.yellow,
  ),
  // disable appbar color change on scroll
  appBarTheme: const AppBarTheme(
    scrolledUnderElevation: 0.0,
  )
);