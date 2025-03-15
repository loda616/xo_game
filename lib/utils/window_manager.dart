import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'platform_utils.dart';

class WindowUtils {
  static Future<void> initializeWindow() async {
    if (!PlatformUtils.isDesktop) return;

    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(PlatformUtils.defaultWindowWidth, PlatformUtils.defaultWindowHeight),
      minimumSize: Size(PlatformUtils.minWindowWidth, PlatformUtils.minWindowHeight),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  static Future<void> setWindowSize({
    double? width,
    double? height,
  }) async {
    if (!PlatformUtils.isDesktop) return;

    Size size = Size(
      width ?? PlatformUtils.defaultWindowWidth,
      height ?? PlatformUtils.defaultWindowHeight,
    );
    await windowManager.setSize(size);
  }

  static Future<void> centerWindow() async {
    if (!PlatformUtils.isDesktop) return;
    await windowManager.center();
  }
}