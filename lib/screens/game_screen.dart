import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/game_state.dart';
import '../widgets/animated_game_cell.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GameScreenContent();
  }
}

class GameScreenContent extends StatelessWidget {
  const GameScreenContent({super.key});

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Settings'),
        content: Consumer<GameState>(
          builder: (context, gameState, child) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Sound Effects'),
                trailing: Switch(
                  value: gameState.soundEnabled,
                  onChanged: (value) {
                    gameState.toggleSound();
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final gameState = context.watch<GameState>();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
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
                    style: theme.textTheme.headlineMedium,
                  ),
                  Row(
                    children: [
                      // Reset Scores Button
                      IconButton(
                        icon: Icon(
                          Icons.restart_alt,
                          color: theme.colorScheme.onBackground,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Reset Scores'),
                              content: const Text('Are you sure you want to reset all scores?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    gameState.resetScores();
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Reset'),
                                ),
                              ],
                            ),
                          );
                        },
                        tooltip: 'Reset Scores',
                      ),
                      // Theme Toggle Button
                      IconButton(
                        icon: Icon(
                          themeProvider.isDarkMode
                              ? Icons.light_mode
                              : Icons.dark_mode,
                          color: theme.colorScheme.onBackground,
                        ),
                        onPressed: () => themeProvider.toggleTheme(),
                        tooltip: 'Toggle Theme',
                      ),
                      // Settings Button
                      IconButton(
                        icon: Icon(
                          Icons.settings,
                          color: theme.colorScheme.onBackground,
                        ),
                        onPressed: () => _showSettingsDialog(context),
                        tooltip: 'Settings',
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Score Board
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildScoreCard(context, 'X'),
                  _buildScoreCard(context, 'O'),
                ],
              ),
              const SizedBox(height: 32),

              // Game Status
              Text(
                gameState.getGameStatus(),
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 24),

              // Game Board
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.cardTheme.color,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: (theme.cardTheme.shape as RoundedRectangleBorder)
                            .side.color,
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
                      itemBuilder: (context, index) => _buildGameCell(context, index),
                    ),
                  ),
                  if (gameState.winningLine != null)
                    TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 600),
                      builder: (context, double progress, _) {
                        return CustomPaint(
                          size: Size.infinite,
                          painter: WinningLinePainter(
                            winningLine: gameState.winningLine!,
                            progress: progress,
                            color: gameState.getCellValue(gameState.winningLine![0]) == 'X'
                                ? theme.colorScheme.primary
                                : theme.colorScheme.secondary,
                          ),
                        );
                      },
                    ),
                ],
              ),
              const SizedBox(height: 32),

              // Reset Button
              ElevatedButton.icon(
                onPressed: gameState.resetGame,
                icon: const Icon(Icons.refresh),
                label: const Text('New Game'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreCard(BuildContext context, String player) {
    final theme = Theme.of(context);
    final gameState = context.watch<GameState>();
    final playerColor = player == 'X'
        ? theme.colorScheme.primary
        : theme.colorScheme.secondary;

    return Container(
      width: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (theme.cardTheme.shape as RoundedRectangleBorder).side.color,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Player $player',
            style: theme.textTheme.titleLarge?.copyWith(
              color: playerColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${gameState.getPlayerScore(player)}',
            style: theme.textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildGameCell(BuildContext context, int index) {
    final theme = Theme.of(context);
    final gameState = context.watch<GameState>();
    final cellValue = gameState.getCellValue(index);
    final playerColor = cellValue == 'X'
        ? theme.colorScheme.primary
        : theme.colorScheme.secondary;

    return AnimatedGameCell(
      value: cellValue,
      onTap: () => gameState.makeMove(index),
      backgroundColor: theme.elevatedButtonTheme.style?.backgroundColor?.resolve({})
          ?? theme.cardColor,
      textColor: cellValue.isNotEmpty ? playerColor : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
    );
  }
}

class WinningLinePainter extends CustomPainter {
  final List<int> winningLine;
  final double progress;
  final Color color;

  WinningLinePainter({
    required this.winningLine,
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    final cellSize = (size.width - 40) / 3;
    final startCell = winningLine.first;
    final endCell = winningLine.last;

    final startX = (startCell % 3) * cellSize + cellSize / 2 + 16;
    final startY = (startCell ~/ 3) * cellSize + cellSize / 2 + 16;
    final endX = (endCell % 3) * cellSize + cellSize / 2 + 16;
    final endY = (endCell ~/ 3) * cellSize + cellSize / 2 + 16;

    final start = Offset(startX, startY);
    final end = Offset(
      startX + (endX - startX) * progress,
      startY + (endY - startY) * progress,
    );

    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(WinningLinePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.winningLine != winningLine;
  }
}