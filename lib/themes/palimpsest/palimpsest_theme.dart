import 'package:flutter/material.dart';
import 'package:pimankagom/themes/palimpsest/palimpsest_app_bar_theme.dart';
import 'package:pimankagom/themes/palimpsest/palimpsest_color_scheme.dart';
import 'package:pimankagom/themes/palimpsest/palimpsest_navigation_bar_theme.dart';
import 'package:pimankagom/themes/palimpsest/palimpsest_text_theme.dart';

final ThemeData palimpsestLightTheme = ThemeData(
  colorScheme: palimpsestColorScheme,
  textTheme: palimpsestTextTheme,
  appBarTheme: palimpsestAppBarTheme,
  navigationBarTheme: palimpsestNavigationBarTheme,
);

final ThemeData palimpsestDarkTheme = ThemeData.dark().copyWith(
  textTheme: TextTheme(
    displayLarge: TextStyle(fontSize: 57, letterSpacing: -0.25),
    displayMedium: TextStyle(fontSize: 45),
    displaySmall: TextStyle(fontSize: 36),
    headlineLarge: TextStyle(fontSize: 32, letterSpacing: -0.3),
    headlineMedium: TextStyle(fontSize: 28, letterSpacing: -0.3),
    headlineSmall: TextStyle(fontSize: 24),
    titleLarge: TextStyle(fontSize: 22, height: 1.5), // 22
    titleMedium: TextStyle(fontSize: 20), // 16
    titleSmall: TextStyle(fontSize: 14),
    bodyLarge: TextStyle(fontSize: 18, height: 1.55),
    bodyMedium: TextStyle(fontSize: 18, height: 1.5), // 16
    bodySmall: TextStyle(fontSize: 12),
    labelLarge: TextStyle(fontSize: 14, letterSpacing: 1.0),
    labelMedium: TextStyle(fontSize: 12, letterSpacing: 3.1),
    labelSmall: TextStyle(fontSize: 11, letterSpacing: 5.5),
  ),
);
