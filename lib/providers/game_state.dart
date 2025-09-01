import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:tic_tac_toe/utils/haptic_feedback_manager.dart';

class GameState extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final HapticFeedbackManager _hapticFeedbackManager = HapticFeedbackManager();
  bool _soundEnabled = true;

  static const String _scoreXKey = 'score_x';
  static const String _scoreOKey = 'score_o';
  static const String _soundEnabledKey = 'sound_enabled';

  late SharedPreferences _prefs;

  final List<String> _board = List.filled(9, '');
  List<String> get board => _board;

  String _currentPlayer = 'X';
  String get currentPlayer => _currentPlayer;

  bool _gameOver = false;
  bool get gameOver => _gameOver;

  final Map<String, int> _scores = {'X': 0, 'O': 0};
  Map<String, int> get scores => _scores;

  String? _winner;
  String? get winner => _winner;

  List<int>? _winningLine;
  List<int>? get winningLine => _winningLine;

  bool get soundEnabled => _soundEnabled;

  Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    // Load saved scores and settings
    _scores['X'] = _prefs.getInt(_scoreXKey) ?? 0;
    _scores['O'] = _prefs.getInt(_scoreOKey) ?? 0;
    _soundEnabled = _prefs.getBool(_soundEnabledKey) ?? true;
    await _audioPlayer.setVolume(1.0);
    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playSound(String soundName) async {
    if (!_soundEnabled) return;
    try {
      await _audioPlayer.stop();
      final source = AssetSource('sounds/$soundName.mp3');
      await _audioPlayer.play(source);
    } catch (e) {
      if (kDebugMode) {
        print('Sound Error: Failed to play $soundName.mp3 - $e');
      }
      // You could add additional error handling or fallback logic here
    }
  }

  Future<void> toggleSound() async {
    _soundEnabled = !_soundEnabled;
    await _prefs.setBool(_soundEnabledKey, _soundEnabled);
    notifyListeners();
  }

  Future<void> _saveScores() async {
    await _prefs.setInt(_scoreXKey, _scores['X']!);
    await _prefs.setInt(_scoreOKey, _scores['O']!);
  }

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
        _winningLine = line;
        _gameOver = true;
        _scores[_winner!] = _scores[_winner!]! + 1;
        _saveScores();
        _hapticFeedbackManager.vibrate(HapticPattern.win);
        _playSound('win');  // Play win sound
        notifyListeners();
        return;
      }
    }

    if (!_board.contains('')) {
      _gameOver = true;
      _winner = null;
      _winningLine = null;
      _hapticFeedbackManager.vibrate(HapticPattern.draw);
      _playSound('draw');
      notifyListeners();
    }
  }

  void makeMove(int index) {
    if (_board[index].isNotEmpty || _gameOver) return;

    _board[index] = _currentPlayer;
    _hapticFeedbackManager.vibrate(HapticPattern.move);
    _playSound('click');  // Play move sound

    _checkWinner();

    if (!_gameOver) {
      _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
    }

    notifyListeners();
  }

  void resetGame() {
    _board.fillRange(0, 9, '');
    _currentPlayer = 'X';
    _gameOver = false;
    _winner = null;
    _winningLine = null;
    _hapticFeedbackManager.vibrate(HapticPattern.move);
    _playSound('reset');
    notifyListeners();
  }

  Future<void> resetScores() async {
    _scores['X'] = 0;
    _scores['O'] = 0;
    await _saveScores();
    _hapticFeedbackManager.vibrate(HapticPattern.move);
    _playSound('reset');
    notifyListeners();
  }

  String getGameStatus() {
    if (_gameOver) {
      if (_winner != null) {
        return 'Player $_winner Wins!';
      }
      return "It's a Draw!";
    }
    return 'Current Turn: Player $_currentPlayer';
  }

  bool isCellEmpty(int index) => _board[index].isEmpty;
  String getCellValue(int index) => _board[index];
  int getPlayerScore(String player) => _scores[player] ?? 0;
}