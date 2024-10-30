import 'package:flutter/material.dart';
import 'core/utils/theme.dart';
import 'features/home/presentation/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic-Tac-Toe',
      theme: AppTheme.themeData,
      home: HomePage(),
    );
  }
}
