import 'package:flutter/material.dart';

const _defaultTextStyle = TextStyle(fontFamily: 'Garamond');

const textTheme = TextTheme(
  displayLarge: _defaultTextStyle,
  displayMedium: _defaultTextStyle,
  displaySmall: _defaultTextStyle,
  headlineLarge: _defaultTextStyle,
  headlineMedium: _defaultTextStyle,
  headlineSmall: _defaultTextStyle,
  titleLarge: _defaultTextStyle,
  titleMedium: _defaultTextStyle,
  titleSmall: _defaultTextStyle,
  bodyLarge: _defaultTextStyle,
  bodyMedium: _defaultTextStyle,
  bodySmall: _defaultTextStyle,
  labelLarge: _defaultTextStyle,
  labelMedium: _defaultTextStyle,
  labelSmall: _defaultTextStyle,
);

final colorScheme = ColorScheme.fromSeed(seedColor: Colors.orangeAccent).copyWith();

final ThemeData basicLightTheme = ThemeData(
  useMaterial3: true,
  textTheme: textTheme,
  colorScheme: colorScheme,
  appBarTheme: const AppBarTheme(centerTitle: true),
  iconTheme: const IconThemeData(),
  navigationBarTheme: NavigationBarThemeData(
    labelTextStyle: WidgetStateTextStyle.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const TextStyle(fontWeight: FontWeight.bold);
      }
      return const TextStyle(fontWeight: FontWeight.normal);
    }),
  ),
);

final ThemeData basicDarkTheme = ThemeData.dark(useMaterial3: true).copyWith();
