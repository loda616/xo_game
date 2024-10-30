# Tic-Tac-Toe Game with Flutter

A minimalist tic-tac-toe game built with Flutter that follows SOLID principles and clean architecture by feature.

## Features

- Custom animated X and O shapes on the home page
- Game board with 9 tiles for X and O
- Save game results with player names using SharedPreferences
- View saved games with winner and loser names

## Project Structure
lib/
├── core/
│   ├── utils/
│   │   ├── theme.dart
│   │   ├── size_config.dart
│   │   └── shared_prefs_helper.dart
│   └── widgets/
│       └── animated_xo.dart
├── features/
│   ├── home/
│   │   ├── presentation/
│   │   │   ├── home_page.dart
│   │   │   └── home_controller.dart
│   ├── game/
│   │   ├── presentation/
│   │   │   ├── game_page.dart
│   │   │   └── game_controller.dart
│   │   └── data/
│   │       └── game_logic.dart
│   ├── saved_games/
│       ├── presentation/
│       │   ├── saved_games_page.dart
│       │   └── saved_games_controller.dart
│       └── data/
│           └── saved_games_repository.dart
└── main.dart

- **core**: Contains theme, size configuration, and shared preferences helper.
- **features**: Divided by feature with folders for `home`, `game`, and `saved_games`.

## Installation

1. Clone the repository.
2. Run `flutter pub get` to install dependencies.
3. Run the app using `flutter run`.

## Screenshots

*Coming soon!*

## License

MIT
