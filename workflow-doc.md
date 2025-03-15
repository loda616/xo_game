# XO Game - Workflow Documentation

This document explains the workflow and architecture of the XO Game application, detailing how different components interact with each other.

## Application Architecture

The application follows a Provider-based state management pattern with a clear separation of concerns:

```
┌─────────────────┐      ┌─────────────────┐      ┌─────────────────┐
│                 │      │                 │      │                 │
│    Providers    │◄────►│     Screens     │◄────►│     Widgets     │
│                 │      │                 │      │                 │
└─────────────────┘      └─────────────────┘      └─────────────────┘
        ▲                                                  ▲
        │                                                  │
        │                ┌─────────────────┐              │
        │                │                 │              │
        └───────────────►│  Theme & Utils  │◄─────────────┘
                         │                 │
                         └─────────────────┘
```

## Initialization Flow

1. **Entry Point (`main.dart`)**:
   - Initializes Flutter binding
   - Sets up window configuration for desktop platforms
   - Initializes SharedPreferences for persistent storage
   - Creates providers (GameState and ThemeProvider)
   - Runs the app with providers at the root

2. **Theme Setup**:
   - `ThemeProvider` reads saved theme preference
   - Appropriate theme (light/dark) is applied to the MaterialApp

## Game State Management

The game logic is centralized in the `GameState` class which extends `ChangeNotifier`:

```
┌───────────────────────────────────────┐
│              GameState                │
├───────────────────────────────────────┤
│ - _board: List<String>                │
│ - _currentPlayer: String              │
│ - _gameOver: bool                     │
│ - _winner: String?                    │
│ - _winningLine: List<int>?            │
│ - _scores: Map<String, int>           │
├───────────────────────────────────────┤
│ + makeMove(index): void               │
│ + resetGame(): void                   │
│ + resetScores(): void                 │
│ + getGameStatus(): String             │
│ + getCellValue(index): String         │
└───────────────────────────────────────┘
```

## User Interaction Flow

1. **Game Initialization**:
   - `GameState` initializes with an empty board and 'X' as the starting player
   - Scores are loaded from SharedPreferences

2. **Player Move**:
   - User taps a cell, triggering `onTap` callback
   - `GameState.makeMove(index)` is called
   - Cell is marked with current player's symbol ('X' or 'O')
   - Sound effect plays and haptic feedback triggers
   - Game checks for a winner or draw condition

3. **Winner Detection**:
   - `_checkWinner()` method checks all possible winning combinations
   - If a winning combination is found:
     - Winner is set
     - Winning line indices are stored
     - Game is marked as over
     - Score is incremented and saved
     - Win sound and haptic feedback are triggered
   - If all cells are filled with no winner:
     - Game is marked as over with no winner (draw)
     - Draw sound and haptic feedback are triggered

4. **Game Reset**:
   - User taps "New Game" button
   - Board is cleared, game state is reset
   - Player 'X' becomes active again

5. **Theme Toggle**:
   - User taps theme toggle icon
   - Theme preference is toggled and saved
   - UI updates to reflect the new theme

## UI Update Flow

Updates to the UI follow a reactive pattern through Provider:

1. Changes to game state trigger `notifyListeners()`
2. Widget tree rebuilds where `context.watch<GameState>()` is used
3. UI reflects the current state of the game

## Animation Flow

The game features several animations:

### Cell Animation

1. `AnimatedGameCell` listens for changes to its value
2. When value changes from empty to a player symbol:
   - Scale animation starts from 0.5 to 1.0 with elastic curve
   - Opacity animation fades in the symbol

### Winning Line Animation

1. When `winningLine` is set in GameState:
   - `WinningLinePainter` draws a line connecting the winning cells
   - Animation progresses from 0.0 to 1.0, extending the line across the winning cells

## Data Persistence Flow

1. **Game Scores**:
   - Scores are saved to SharedPreferences when updated
   - Loaded when the app starts

2. **Theme Preference**:
   - Theme setting (light/dark) is saved when changed
   - Loaded when the app starts

## Cross-Platform Adaptations

1. **Platform Detection**:
   - `PlatformUtils` detects the current platform
   - UI adapts based on platform (desktop vs mobile)

2. **Desktop Window Management**:
   - For desktop platforms, `WindowUtils` configures the window size and behavior

## Sound and Haptic Feedback

1. **Sound Effects**:
   - Sound effects are tied to game events (move, win, draw, reset)
   - Controlled by the `_soundEnabled` preference

2. **Haptic Feedback**:
   - Different vibration patterns for different events
   - Only active on devices with vibration capability

## Component Communication

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│  GameScreen     │     │   GameState     │     │  ThemeProvider  │
├─────────────────┤     ├─────────────────┤     ├─────────────────┤
│ Displays UI     │     │ Manages logic   │     │ Manages themes  │
│ Handles input   │◄───►│ Updates state   │     │ Provides colors │
│ Shows animations│     │ Triggers sounds │◄───►│ Saves preference│
└─────────────────┘     └─────────────────┘     └─────────────────┘
        ▲                       ▲                       ▲
        │                       │                       │
        ▼                       │                       │
┌─────────────────┐             │                       │
│  UI Components  │             │                       │
├─────────────────┤             │                       │
│ AnimatedGameCell│◄────────────┘                       │
│ WinningLinePaint│◄────────────────────────────────────┘
└─────────────────┘
```

## Debugging and Testing

1. To test different game scenarios:
   - Modify the `_board` array directly in debug mode
   - Call `_checkWinner()` to validate win detection
   - Test persistence by closing and reopening the app

2. To test different platforms:
   - Run on mobile: `flutter run -d android` or `flutter run -d ios`
   - Run on desktop: `flutter run -d windows|macos|linux`

## Build and Deployment Process

1. **Development Build**:
   ```bash
   flutter build apk --debug
   flutter build ios --debug
   flutter build windows --debug
   ```

2. **Production Build**:
   ```bash
   flutter build apk --release
   flutter build appbundle --release
   flutter build ios --release
   flutter build windows --release
   flutter build macos --release
   flutter build linux --release
   ```

## Code Extension Points

The architecture allows for easy extension in several areas:

1. **New Game Features**:
   - Add AI opponent by extending GameState
   - Add multiplayer by modifying GameState to handle remote moves
   - Add game variations by changing the win condition logic

2. **UI Enhancements**:
   - Add more themes by extending AppTheme
   - Add animations by creating new AnimatedWidgets
   - Add customization options in the settings dialog

## Performance Considerations

1. **Animation Performance**:
   - Use of `AnimationController` with vsync for efficient animations
   - Custom painters for drawing winning lines instead of widget overlays

2. **State Management**:
   - Selective rebuilds with Provider to minimize UI updates
   - Game logic isolated from UI for better testability and performance
