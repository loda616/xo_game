import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themePreferenceKey = 'theme_preference';
  final SharedPreferences _prefs;

  late ThemeMode _themeMode;

  ThemeProvider(this._prefs) {
    final themeIndex = _prefs.getInt(_themePreferenceKey);
    if (themeIndex == null) {
      _themeMode = ThemeMode.system;
    } else {
      _themeMode = ThemeMode.values[themeIndex];
    }
  }

  ThemeMode get themeMode => _themeMode;

  bool isDarkMode(BuildContext context) {
    if (_themeMode == ThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }

  Future<void> toggleTheme() async {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else if (_themeMode == ThemeMode.dark) {
      _themeMode = ThemeMode.system;
    } else {
      _themeMode = ThemeMode.light;
    }
    await _prefs.setInt(_themePreferenceKey, _themeMode.index);
    notifyListeners();
  }

  Color playerXColor(BuildContext context) => isDarkMode(context)
      ? AppTheme.darkTheme.colorScheme.primary
      : AppTheme.lightTheme.colorScheme.primary;

  Color playerOColor(BuildContext context) => isDarkMode(context)
      ? AppTheme.darkTheme.colorScheme.secondary
      : AppTheme.lightTheme.colorScheme.secondary;

  Color backgroundColor(BuildContext context) => isDarkMode(context)
      ? AppTheme.darkTheme.scaffoldBackgroundColor
      : AppTheme.lightTheme.scaffoldBackgroundColor;

  Color cardColor(BuildContext context) => isDarkMode(context)
      ? AppTheme.darkTheme.cardTheme.color!
      : AppTheme.lightTheme.cardTheme.color!;

  Color textColor(BuildContext context) => isDarkMode(context)
      ? AppTheme.darkTheme.colorScheme.onBackground
      : AppTheme.lightTheme.colorScheme.onBackground;
}