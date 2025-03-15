import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themePreferenceKey = 'theme_preference';
  final SharedPreferences _prefs;

  ThemeProvider(this._prefs) {
    _isDarkMode = _prefs.getBool(_themePreferenceKey) ?? true;
  }

  bool _isDarkMode = true;
  bool get isDarkMode => _isDarkMode;

  ThemeData get theme => _isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _prefs.setBool(_themePreferenceKey, _isDarkMode);
    notifyListeners();
  }

  Color get playerXColor => _isDarkMode
      ? AppTheme.darkTheme.colorScheme.primary
      : AppTheme.lightTheme.colorScheme.primary;

  Color get playerOColor => _isDarkMode
      ? AppTheme.darkTheme.colorScheme.secondary
      : AppTheme.lightTheme.colorScheme.secondary;

  Color get backgroundColor => theme.scaffoldBackgroundColor;
  Color get cardColor => theme.cardTheme.color!;
  Color get textColor => _isDarkMode
      ? AppTheme.darkTheme.colorScheme.onBackground
      : AppTheme.lightTheme.colorScheme.onBackground;
}