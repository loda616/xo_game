import 'package:shared_preferences/shared_preferences.dart';

class SavedGamesRepository {
  final String _savedGamesKey = 'savedGames';

  Future<void> saveGameResult(String winner, String loser) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedGames = prefs.getStringList(_savedGamesKey) ?? [];
    savedGames.add('$winner:$loser');
    await prefs.setStringList(_savedGamesKey, savedGames);
  }

  Future<List<String>> fetchSavedGames() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_savedGamesKey) ?? [];
  }
}
