import 'package:flutter/foundation.dart';
import 'package:vibration/vibration.dart';

enum HapticPattern {
  move,
  win,
  draw,
}

class HapticFeedbackManager {
  Future<void> vibrate(HapticPattern pattern) async {
    if (await Vibration.hasVibrator() ?? false) {
      switch (pattern) {
        case HapticPattern.move:
          Vibration.vibrate(duration: 40);
          break;
        case HapticPattern.win:
          Vibration.vibrate(
            pattern: [0, 100, 100, 100],
            intensities: [0, 128, 0, 255],
          );
          break;
        case HapticPattern.draw:
          Vibration.vibrate(duration: 150);
          break;
      }
    }
  }
}
