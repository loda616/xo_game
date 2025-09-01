import 'dart:ui';
import 'package:flutter/material.dart';

class WinningLinePainter extends CustomPainter {
  final List<int> winningLine;
  final double progress;
  final Color color;
  final Offset startOffset;
  final Offset endOffset;

  WinningLinePainter({
    required this.winningLine,
    required this.progress,
    required this.color,
    required Size size,
  })  : startOffset = _calculateOffset(winningLine.first, size),
        endOffset = _calculateOffset(winningLine.last, size);

  static Offset _calculateOffset(int cellIndex, Size size) {
    final cellSize = (size.width - 40) / 3;
    final col = cellIndex % 3;
    final row = cellIndex ~/ 3;
    return Offset(
      col * cellSize + cellSize / 2 + 16,
      row * cellSize + cellSize / 2 + 16,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    final currentEnd = Offset(
      startOffset.dx + (endOffset.dx - startOffset.dx) * progress,
      startOffset.dy + (endOffset.dy - startOffset.dy) * progress,
    );

    canvas.drawLine(startOffset, currentEnd, paint);
  }

  @override
  bool shouldRepaint(WinningLinePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.winningLine != winningLine;
  }
}