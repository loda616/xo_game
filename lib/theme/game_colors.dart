import 'package:flutter/material.dart';

class GameColors {
  final BuildContext context;

  GameColors(this.context);

  ThemeData get _theme => Theme.of(context);

  Color get playerXColor => _theme.colorScheme.primary;
  Color get playerOColor => _theme.colorScheme.secondary;

  Color playerColor(String player) {
    return player == 'X' ? playerXColor : playerOColor;
  }

  Color winningLineColor(String? player) {
    if (player == null) return Colors.transparent;
    return playerColor(player);
  }
}
