import 'package:flutter/material.dart';

final _colorScheme = ColorScheme.fromSeed(seedColor: Colors.orangeAccent).copyWith();

const _defaultTextStyle = TextStyle(fontFamily: 'Garamond');

final _textTheme = TextTheme(
  displayLarge: _defaultTextStyle.copyWith(
    fontSize: 57.0,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
    height: 1.12,
  ),
  displayMedium: _defaultTextStyle.copyWith(
    fontSize: 45.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    height: 1.16,
  ),
  displaySmall: _defaultTextStyle.copyWith(
    fontSize: 36.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    height: 1.22,
  ),
  headlineLarge: _defaultTextStyle.copyWith(
    fontSize: 32.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    height: 1.25,
  ),
  headlineMedium: _defaultTextStyle.copyWith(
    fontSize: 28.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    height: 1.29,
  ),
  headlineSmall: _defaultTextStyle.copyWith(
    fontSize: 24.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    height: 1.33,
  ),
  titleLarge: _defaultTextStyle.copyWith(
    fontSize: 22.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    height: 1.27,
  ),
  titleMedium: _defaultTextStyle.copyWith(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    height: 1.50,
  ),
  titleSmall: _defaultTextStyle.copyWith(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
  ),
  bodyLarge: _defaultTextStyle.copyWith(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.50,
  ),
  bodyMedium: _defaultTextStyle.copyWith(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
  ),
  bodySmall: _defaultTextStyle.copyWith(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
  ),
  labelLarge: _defaultTextStyle.copyWith(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
  ),
  labelMedium: _defaultTextStyle.copyWith(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.33,
  ),
  labelSmall: _defaultTextStyle.copyWith(
    fontSize: 11.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.45,
  ),
);

final ThemeData pimankagomLightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: _colorScheme,
  textTheme: _textTheme,
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

final ThemeData pimankagomDarkTheme = ThemeData.dark(useMaterial3: true).copyWith();
