import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PlatformUtils {
  static bool get isDesktop {
    if (kIsWeb) return false;
    return Platform.isWindows || Platform.isLinux || Platform.isMacOS;
  }

  static bool get isWindows {
    if (kIsWeb) return false;
    return Platform.isWindows;
  }

  // Minimum window dimensions
  static const double minWindowWidth = 400.0;
  static const double minWindowHeight = 600.0;

  // Recommended window dimensions
  static const double defaultWindowWidth = 450.0;
  static const double defaultWindowHeight = 700.0;

  // Safe area paddings
  static EdgeInsets get defaultPadding {
    if (isDesktop) {
      return const EdgeInsets.all(24.0);
    }
    return const EdgeInsets.all(16.0);
  }

  // Game board dimensions
  static double getGameBoardSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double minDimension = screenWidth < screenHeight ? screenWidth : screenHeight;

    if (isDesktop) {
      return minDimension * 0.6; // 60% of screen for desktop
    }
    return minDimension * 0.8; // 80% of screen for mobile
  }

  // Cell size calculations
  static double getCellSize(BuildContext context) {
    double boardSize = getGameBoardSize(context);
    return (boardSize - (32 + 16)) / 3; // Accounting for padding and gaps
  }

  // Font sizes
  static double getTitleFontSize(BuildContext context) {
    if (isDesktop) {
      return 28.0;
    }
    return 24.0;
  }

  static double getScoreFontSize(BuildContext context) {
    if (isDesktop) {
      return 24.0;
    }
    return 20.0;
  }

  static double getGameSymbolFontSize(BuildContext context) {
    if (isDesktop) {
      return 48.0;
    }
    return 32.0;
  }
}