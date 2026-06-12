import 'package:flutter/material.dart';

final palimpsestNavigationBarTheme = NavigationBarThemeData(
  labelTextStyle: WidgetStateTextStyle.resolveWith((states) {
    if (states.contains(WidgetState.selected)) {
      return const TextStyle(fontWeight: FontWeight.bold);
    }
    return const TextStyle(fontWeight: FontWeight.normal);
  }),
);
