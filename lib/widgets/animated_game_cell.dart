import 'package:flutter/material.dart';

class AnimatedGameCell extends StatefulWidget {
  final String value;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;
  final BorderRadius borderRadius;

  const AnimatedGameCell({
    super.key,
    required this.value,
    required this.onTap,
    required this.backgroundColor,
    required this.textColor,
    required this.borderRadius,
  });

  @override
  State<AnimatedGameCell> createState() => _AnimatedGameCellState();
}

class _AnimatedGameCellState extends State<AnimatedGameCell>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
  }

  @override
  void didUpdateWidget(AnimatedGameCell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value.isNotEmpty && oldWidget.value.isEmpty) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.backgroundColor,
      borderRadius: widget.borderRadius,
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: widget.borderRadius,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: widget.value.isNotEmpty ? _scaleAnimation.value : 1.0,
              child: Center(
                child: FadeTransition(
                  opacity: _opacityAnimation,
                  child: Text(
                    widget.value,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: widget.textColor,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}