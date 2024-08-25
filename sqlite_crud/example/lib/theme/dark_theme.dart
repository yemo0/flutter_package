import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: Colors.blueAccent,
    secondary: Colors.blue,
    onSecondary: Colors.white,
    tertiary: Colors.yellow,
  )
);

ThemeData darkModeCool = darkMode.copyWith(

);