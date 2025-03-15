import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/platform_utils.dart';
import 'utils/window_manager.dart';
import 'providers/theme_provider.dart';
import 'providers/game_state.dart';
import 'screens/game_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize window if on desktop
  if (PlatformUtils.isDesktop) {
    await WindowUtils.initializeWindow();
  }

  final prefs = await SharedPreferences.getInstance();
  final gameState = GameState();
  await gameState.initPrefs();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(prefs)),
        ChangeNotifierProvider.value(value: gameState),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'XO Game',
          theme: themeProvider.theme,
          home: const GameScreen(),
          builder: (context, child) {
            return MediaQuery(
              // Ensure proper sizing on all platforms
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: 1.0,
              ),
              child: child!,
            );
          },
        );
      },
    );
  }
}