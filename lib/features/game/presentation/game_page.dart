import 'package:flutter/material.dart';
import 'game_controller.dart';

class GamePage extends StatelessWidget {
  final GameController _controller = GameController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.all(20.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _controller.onBoxTapped(index),
            child: Container(
              color: Colors.black,
              child: Center(
                child: Text(
                  _controller.board[index] ?? '',
                  style: const TextStyle(color: Colors.white, fontSize: 48),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
