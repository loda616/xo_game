import 'package:flutter/material.dart';
import 'package:xo_game/widgets/winning_line_painter.dart';
import 'animated_game_cell.dart';

class GameBoard extends StatefulWidget {
  final List<String> board;
  final Function(int) onCellTap;
  final List<int>? winningLine;
  final ThemeData theme;
  final Color playerXColor;
  final Color playerOColor;
  final Color backgroundColor;
  final Color borderColor;

  const GameBoard({
    super.key,
    required this.board,
    required this.onCellTap,
    required this.winningLine,
    required this.theme,
    required this.playerXColor,
    required this.playerOColor,
    required this.backgroundColor,
    required this.borderColor,
  });

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> with SingleTickerProviderStateMixin {
  late AnimationController _lineAnimationController;
  late Animation<double> _lineAnimation;

  @override
  void initState() {
    super.initState();
    _lineAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _lineAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _lineAnimationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(GameBoard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.winningLine != null && oldWidget.winningLine == null) {
      _lineAnimationController.forward(from: 0.0);
    } else if (widget.winningLine == null && oldWidget.winningLine != null) {
      _lineAnimationController.reset();
    }
  }

  @override
  void dispose() {
    _lineAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: widget.borderColor),
          ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: 9,
            itemBuilder: (context, index) => AnimatedGameCell(
              value: widget.board[index],
              onTap: () => widget.onCellTap(index),
              backgroundColor: widget.backgroundColor,
              textColor: widget.board[index] == 'X'
                  ? widget.playerXColor
                  : widget.playerOColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        if (widget.winningLine != null)
          AnimatedBuilder(
            animation: _lineAnimation,
            builder: (context, child) {
              return CustomPaint(
                size: Size.infinite,
                painter: WinningLinePainter(
                  winningLine: widget.winningLine!,
                  progress: _lineAnimation.value,
                  color: widget.board[widget.winningLine![0]] == 'X'
                      ? widget.playerXColor
                      : widget.playerOColor,
                ),
              );
            },
          ),
      ],
    );
  }
}
