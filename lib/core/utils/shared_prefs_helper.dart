import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static Future<void> saveGame(String winner, String loser) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedGames = prefs.getStringList('savedGames') ?? [];
    savedGames.add('$winner:$loser');
    await prefs.setStringList('savedGames', savedGames);
  }

  static Future<List<String>> getSavedGames() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('savedGames') ?? [];
  }
}
