import 'package:flutter/material.dart';

class AnimatedXO extends StatelessWidget {
  final bool isX;

  const AnimatedXO({required this.isX, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: Text(
        isX ? 'X' : 'O',
        key: ValueKey(isX),
        style: const TextStyle(
          fontSize: 100,
          color: Colors.black,
        ),
      ),
    );
  }
}
