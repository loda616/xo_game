import '../data/saved_games_repository.dart';

class SavedGamesController {
  final SavedGamesRepository _repository = SavedGamesRepository();

  Future<List<String>> getSavedGames() async {
    return await _repository.fetchSavedGames();
  }

  Future<void> saveGameResult(String winner, String loser) async {
    await _repository.saveGameResult(winner, loser);
  }
}
