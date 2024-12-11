import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';

class GameState extends ChangeNotifier {
  // Audio player setup
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _soundEnabled = true;

  // Keys for SharedPreferences
  static const String _scoreXKey = 'score_x';
  static const String _scoreOKey = 'score_o';
  static const String _soundEnabledKey = 'sound_enabled';

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

  // Winning line
  List<int>? _winningLine;
  List<int>? get winningLine => _winningLine;

  // Sound state
  bool get soundEnabled => _soundEnabled;

  // Initialize preferences and audio
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

  // Sound effect methods
  Future<void> _playSound(String soundName) async {
    if (!_soundEnabled) return;
    try {
      await _audioPlayer.stop();
      final source = AssetSource('sounds/$soundName.mp3');
      await _audioPlayer.play(source);
    } catch (e) {
      print('Sound Error: Failed to play $soundName.mp3 - $e');
      // You could add additional error handling or fallback logic here
    }
  }

  Future<void> toggleSound() async {
    _soundEnabled = !_soundEnabled;
    await _prefs.setBool(_soundEnabledKey, _soundEnabled);
    notifyListeners();
  }

  // Haptic feedback methods (existing code)
  void _moveHaptic() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 40);
    }
  }

  void _winHaptic() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(
        pattern: [0, 100, 100, 100],
        intensities: [0, 128, 0, 255],
      );
    }
  }

  void _drawHaptic() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 150);
    }
  }

  // Save scores to persistent storage
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
        _winHaptic();
        _playSound('win');  // Play win sound
        notifyListeners();
        return;
      }
    }

    if (!_board.contains('')) {
      _gameOver = true;
      _winner = null;
      _winningLine = null;
      _drawHaptic();
      _playSound('draw');  // Play draw sound
      notifyListeners();
    }
  }

  void makeMove(int index) {
    if (_board[index].isNotEmpty || _gameOver) return;

    _board[index] = _currentPlayer;
    _moveHaptic();
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
    _moveHaptic();
    _playSound('reset');  // Play reset sound
    notifyListeners();
  }

  Future<void> resetScores() async {
    _scores['X'] = 0;
    _scores['O'] = 0;
    await _saveScores();
    _moveHaptic();
    _playSound('reset');  // Play reset sound
    notifyListeners();
  }

  // Existing helper methods remain the same
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