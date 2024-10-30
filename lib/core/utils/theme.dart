import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData themeData = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.black,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
    ),
  );
}
