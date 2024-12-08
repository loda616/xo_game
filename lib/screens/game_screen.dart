import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<String> _board = List.filled(9, '');
  String _currentPlayer = 'X';
  bool _gameOver = false;
  final Map<String, int> _scores = {'X': 0, 'O': 0};

  // Check for winner
  String? _checkWinner() {
    const lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8], // Rows
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8], // Columns
      [0, 4, 8],
      [2, 4, 6] // Diagonals
    ];

    for (final line in lines) {
      final [a, b, c] = line;
      if (_board[a].isNotEmpty &&
          _board[a] == _board[b] &&
          _board[a] == _board[c]) {
        return _board[a];
      }
    }
    return null;
  }

  // Handle cell tap
  void _handleCellTap(int index) {
    if (_board[index].isNotEmpty || _gameOver) return;

    setState(() {
      _board[index] = _currentPlayer;

      final winner = _checkWinner();
      if (winner != null) {
        _scores[winner] = _scores[winner]! + 1;
        _gameOver = true;
      } else if (!_board.contains('')) {
        // Draw
        _gameOver = true;
      } else {
        _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
      }
    });
  }

  // Reset game
  void _resetGame() {
    setState(() {
      _board.fillRange(0, 9, '');
      _currentPlayer = 'X';
      _gameOver = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'XO Game',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkText,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    color: AppColors.darkText,
                    onPressed: () {
                      // TODO: Implement settings
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Score Board
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildScoreCard('X', AppColors.playerXDark),
                  _buildScoreCard('O', AppColors.playerODark),
                ],
              ),
              const SizedBox(height: 32),

              // Game Status
              Text(
                _gameOver
                    ? _checkWinner() != null
                    ? 'Player ${_checkWinner()} Wins!'
                    : "It's a Draw!"
                    : 'Current Turn: Player $_currentPlayer',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkText,
                ),
              ),
              const SizedBox(height: 24),

              // Game Board
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.darkCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.darkBorder,
                    width: 1,
                  ),
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) => _buildGameCell(index),
                ),
              ),
              const SizedBox(height: 32),

              // Reset Button
              ElevatedButton.icon(
                onPressed: _resetGame,
                icon: const Icon(Icons.refresh),
                label: const Text('New Game'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkButton,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: AppColors.darkBorder,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreCard(String player, Color playerColor) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.darkBorder,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Player $player',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: playerColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${_scores[player]}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.darkText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameCell(int index) {
    return Material(
      color: AppColors.darkButton,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () => _handleCellTap(index),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              _board[index],
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: _board[index] == 'X'
                    ? AppColors.playerXDark
                    : AppColors.playerODark,
              ),
            ),
          ),
        ),
      ),
    );
  }
}