import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final buttonColors = WindowButtonColors(
      iconNormal: colorScheme.onSurface,
      mouseOver: colorScheme.surfaceContainerHighest,
      mouseDown: colorScheme.surfaceContainerHigh,
      iconMouseOver: colorScheme.onSurface,
      iconMouseDown: colorScheme.onSurface,
    );

    final closeButtonColors = WindowButtonColors(
      iconNormal: colorScheme.onSurface,
      mouseOver: colorScheme.error,
      mouseDown: colorScheme.onErrorContainer,
      iconMouseOver: colorScheme.onError,
      iconMouseDown: colorScheme.onError,
    );

    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}
