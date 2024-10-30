import '../data/game_logic.dart';

class GameController {
  List<String?> board = List.generate(9, (_) => null);
  bool isXTurn = true; // This tracks whose turn it is (X or O)
  final GameLogic _gameLogic = GameLogic();

  // Handle box taps
  void onBoxTapped(int index) {
    if (board[index] == null) {
      board[index] = isXTurn ? 'X' : 'O';
      isXTurn = !isXTurn; // Switch turn to the other player

      final winner = _gameLogic.checkWinner();
      if (winner != null) {
        _showEndGameDialog(winner); // Handle end-game logic
      }
    }
  }

  // Resets the board for a new game
  void resetGame() {
    board = List.generate(9, (_) => null);
    isXTurn = true;
  }

  // Example function to show end-game dialog (implementation depends on the UI)
  void _showEndGameDialog(String winner) {
    // Show dialog with TextFields to enter player names
    // and save result with SharedPrefsHelper.saveGame()
    // Note: Implementation would be in the UI code
  }
}
