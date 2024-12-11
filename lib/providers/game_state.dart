import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameState extends ChangeNotifier {
  // Keys for SharedPreferences
  static const String _scoreXKey = 'score_x';
  static const String _scoreOKey = 'score_o';

  late SharedPreferences _prefs;

  // Game board state
  final List<String> _board = List.filled(9, '');
  List<String> get board => _board;

  // Current player
  String _currentPlayer = 'X';
  String get currentPlayer => _currentPlayer;

  // Game status
  bool _gameOver = false;
  bool get gameOver => _gameOver;

  // Player scores with persistence
  final Map<String, int> _scores = {'X': 0, 'O': 0};
  Map<String, int> get scores => _scores;

  // Winner
  String? _winner;
  String? get winner => _winner;

  // Initialize SharedPreferences
  Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    // Load saved scores
    _scores['X'] = _prefs.getInt(_scoreXKey) ?? 0;
    _scores['O'] = _prefs.getInt(_scoreOKey) ?? 0;
    notifyListeners();
  }

  // Save scores to persistent storage
  Future<void> _saveScores() async {
    await _prefs.setInt(_scoreXKey, _scores['X']!);
    await _prefs.setInt(_scoreOKey, _scores['O']!);
  }

  // Check for winner (existing code remains the same)
  void _checkWinner() {
    const lines = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6] // Diagonals
    ];

    for (final line in lines) {
      final [a, b, c] = line;
      if (_board[a].isNotEmpty &&
          _board[a] == _board[b] &&
          _board[a] == _board[c]) {
        _winner = _board[a];
        _gameOver = true;
        _scores[_winner!] = _scores[_winner!]! + 1;
        _saveScores(); // Save scores when they change
        notifyListeners();
        return;
      }
    }

    if (!_board.contains('')) {
      _gameOver = true;
      _winner = null;
      notifyListeners();
    }
  }

  // Handle move (existing code remains the same)
  void makeMove(int index) {
    if (_board[index].isNotEmpty || _gameOver) return;

    _board[index] = _currentPlayer;
    _checkWinner();

    if (!_gameOver) {
      _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
    }

    notifyListeners();
  }

  // Reset game (board only, keeps scores)
  void resetGame() {
    _board.fillRange(0, 9, '');
    _currentPlayer = 'X';
    _gameOver = false;
    _winner = null;
    notifyListeners();
  }

  // Reset scores with persistence
  Future<void> resetScores() async {
    _scores['X'] = 0;
    _scores['O'] = 0;
    await _saveScores();
    notifyListeners();
  }

  // Get game status message
  String getGameStatus() {
    if (_gameOver) {
      if (_winner != null) {
        return 'Player $_winner Wins!';
      }
      return "It's a Draw!";
    }
    return 'Current Turn: Player $_currentPlayer';
  }

  // Check if a cell is empty
  bool isCellEmpty(int index) => _board[index].isEmpty;

  // Get cell value
  String getCellValue(int index) => _board[index];

  // Get player score
  int getPlayerScore(String player) => _scores[player] ?? 0;
}