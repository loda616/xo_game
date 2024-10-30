import 'package:flutter/material.dart';
import '../../game/presentation/game_page.dart';
import '../../../core/widgets/animated_xo.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AnimatedXO(isX: true),
            const SizedBox(height: 20),
            const AnimatedXO(isX: false),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => GamePage()));
              },
              child: const Text('Start New Game'),
            ),
          ],
        ),
      ),
    );
  }
}
