import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF60A5FA),    // Player X color (blue-400)
      secondary: Color(0xFF34D399),   // Player O color (red-400)
      surface: Color(0xFF18181B),     // Card background (zinc-900)
      background: Colors.black,
      onBackground: Colors.white,
      onSurface: Colors.white,
    ),
    cardTheme: CardTheme(
      color: const Color(0xFF18181B), // zinc-900
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Color(0xFF27272A)), // zinc-800
      ),
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF27272A), // zinc-800
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Color(0xFF27272A)), // zinc-800
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF3F4F6), // gray-100
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF2563EB),    // Player X color (blue-600)
      secondary: Color(0xFFDC2626),   // Player O color (red-600)
      surface: Colors.white,
      background: Color(0xFFF3F4F6),  // gray-100
      onBackground: Color(0xFF1F2937), // gray-800
      onSurface: Color(0xFF1F2937),   // gray-800
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Color(0xFFE5E7EB)), // gray-200
      ),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1F2937), // gray-800
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Color(0xFFE5E7EB)), // gray-200
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
      ),
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        color: Color(0xFF1F2937), // gray-800
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: Color(0xFF1F2937), // gray-800
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: Color(0xFF1F2937), // gray-800
        fontSize: 16,
      ),
    ),
  );
}