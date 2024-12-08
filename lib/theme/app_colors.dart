import 'package:flutter/material.dart';

class AppColors {
  // Dark Theme Colors
  static const darkTheme = {
    'backgroundColor': Colors.black,
    'cardColor': Color(0xFF18181B),     // zinc-900
    'buttonColor': Color(0xFF27272A),    // zinc-800
    'buttonHoverColor': Color(0xFF3F3F46), // zinc-700
    'borderColor': Color(0xFF27272A),    // zinc-800
    'playerXColor': Color(0xFF60A5FA),   // blue-400
    'playerOColor': Color(0xFF34D399),   // red-400
    'textColor': Colors.white,
  };

  // Light Theme Colors
  static const lightTheme = {
    'backgroundColor': Color(0xFFF3F4F6),  // gray-100
    'cardColor': Colors.white,
    'buttonColor': Colors.white,
    'buttonHoverColor': Color(0xFFF9FAFB), // gray-50
    'borderColor': Color(0xFFE5E7EB),      // gray-200
    'playerXColor': Color(0xFF2563EB),     // blue-600
    'playerOColor': Color(0xFFDC2626),     // red-600
    'textColor': Color(0xFF1F2937),        // gray-800
  };
}