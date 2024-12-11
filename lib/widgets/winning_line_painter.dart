import 'dart:ui';

import 'package:flutter/material.dart';

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