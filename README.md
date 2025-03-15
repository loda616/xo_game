# XO Game - Modern Tic-Tac-Toe

A beautifully designed, cross-platform Tic-Tac-Toe game built with Flutter. This modern implementation features sleek animations, haptic feedback, sound effects, theme switching, and persistent scoring.


## Features

- 🎮 Clean, responsive UI for both mobile and desktop platforms
- 🎯 Smooth animations for game pieces and winning lines
- 🌓 Light and dark theme support with persistent preference
- 🔊 Sound effects with toggle control
- 📱 Haptic feedback on mobile devices
- 📊 Score tracking with persistent storage
- 💻 Optimized for desktop with proper window management
- 🏆 Winning line animation
- 🔄 Game state management using Provider

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version recommended)
- Dart SDK
- Android Studio, VS Code, or another IDE with Flutter support

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/xo_game.git
   cd xo_game
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart                 # Application entry point
├── screens/
│   └── game_screen.dart      # Main game screen
├── providers/
│   ├── game_state.dart       # Game logic and state management
│   └── theme_provider.dart   # Theme state management
├── theme/
│   ├── app_colors.dart       # Color definitions
│   └── app_theme.dart        # Theme configurations
├── utils/
│   ├── platform_utils.dart   # Platform-specific utilities
│   └── window_manager.dart   # Desktop window management
└── widgets/
    ├── animated_game_cell.dart   # Individual game cell with animations
    ├── game_board.dart           # Complete game board
    └── winning_line_painter.dart # Custom painter for winning line
```

## Game Play

1. The game starts with Player X
2. Players take turns marking empty cells on the 3x3 grid
3. The first player to get three of their marks in a row (horizontally, vertically, or diagonally) wins
4. If all cells are filled and no player has three in a row, the game ends in a draw
5. The score is tracked across multiple games
6. Use the "New Game" button to reset the board and start a new round

## Customization

### Themes

The app comes with both dark and light themes. The theme preference is saved between sessions. Toggle the theme by clicking the sun/moon icon in the top right corner.

### Sound Effects

Sound effects can be toggled on/off through the settings dialog. The preference is saved between sessions.

## Platform Support

- 📱 Android
- 📱 iOS
- 💻 Windows
- 💻 macOS
- 💻 Linux
- 🌐 Web (limited functionality)

## Dependencies

- `provider`: For state management
- `shared_preferences`: For persistent storage
- `window_manager`: For desktop window management
- `audioplayers`: For sound effects
- `vibration`: For haptic feedback

## Contributing

Contributions are welcome! Feel free to submit a pull request or create an issue for any bugs or feature requests.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Flutter team for the amazing framework
- The open-source community for inspirational game implementations