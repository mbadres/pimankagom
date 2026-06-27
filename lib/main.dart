import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pimankagom/ui/app/app.dart';
import 'package:pimankagom/ui/shared/window/desktop_window_support.dart';

void main() {
  runApp(ProviderScope(child: const App()));

  if (isDesktopWindowPlatform) {
    doWhenWindowReady(() {
      const initialSize = Size(1280, 720);
      appWindow.minSize = const Size(480, 360);
      appWindow.size = initialSize;
      appWindow.alignment = Alignment.center;
      appWindow.title = 'Ⲡⲓⲙⲁⲛ̀ⲕⲁϫⲱⲙ';
      appWindow.show();
    });
  }
}
