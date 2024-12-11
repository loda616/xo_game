import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/game_state.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GameScreenContent();
  }
}

class GameScreenContent extends StatelessWidget {
  const GameScreenContent({super.key});

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
                      IconButton(
                        icon: Icon(
                          themeProvider.isDarkMode
                              ? Icons.light_mode
                              : Icons.dark_mode,
                          color: theme.colorScheme.onBackground,
                        ),
                        onPressed: () => themeProvider.toggleTheme(),
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

    return Material(
      color: theme.elevatedButtonTheme.style?.backgroundColor?.resolve({}),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () => gameState.makeMove(index),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              cellValue,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: cellValue.isNotEmpty ? playerColor : Colors.transparent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}