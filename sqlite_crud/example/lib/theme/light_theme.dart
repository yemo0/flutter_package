import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color.fromRGBO(247, 247, 245, 1),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromRGBO(247, 247, 245, 1),
  ),
  colorScheme: const ColorScheme.light(
    primary: Colors.blueAccent,
    secondary: Colors.blue,
    onSecondary: Color.fromRGBO(255, 255, 255, 1),
    tertiary: Colors.yellow,
  )
);