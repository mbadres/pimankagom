import 'package:flutter/material.dart';
import 'package:pimankagom/themes/basic_theme.dart';

final ColorScheme _copticColorScheme = ColorScheme(
  brightness: Brightness.dark,
  // base surfaces
  surface: const Color(0xFF1E2535),
  surfaceContainerLow: const Color(0xFF1B2030),
  surfaceContainerLowest: const Color(0xFF181D2C),
  onSurface: const Color(0xFFE8ECFF),
  // primary — blue-violet
  primary: const Color(0xFF6366F1),
  onPrimary: const Color(0xFFF0F1FF),
  primaryContainer: const Color(0xFF3730A3),
  onPrimaryContainer: const Color(0xFFE0E7FF),
  // secondary — rose/pink
  secondary: const Color(0xFFF472B6),
  onSecondary: const Color(0xFFFCE7F3),
  secondaryContainer: const Color(0xFF9D174D),
  onSecondaryContainer: const Color(0xFFFFE4F0),
  // tertiary — teal (accent)
  tertiary: const Color(0xFF2DD4BF),
  onTertiary: const Color(0xFF134E4A),
  tertiaryContainer: const Color(0xFF0F766E),
  onTertiaryContainer: const Color(0xFFCCFBF1),
  // error — coral/red
  error: const Color(0xFFF87171),
  onError: const Color(0xFF450A0A),
  errorContainer: const Color(0xFF7F1D1D),
  onErrorContainer: const Color(0xFFFEE2E2),
  // neutral background
  outline: const Color(0xFF3F4466),
  outlineVariant: const Color(0xFF2A2F4A),
  shadow: const Color(0xFF0F0F18),
  scrim: const Color(0xFF0F0F18),
  inverseSurface: const Color(0xFFE8ECFF),
  onInverseSurface: const Color(0xFF1E2535),
  inversePrimary: const Color(0xFF4338CA),
);

final ThemeData copticDarkTheme = basicLightTheme.copyWith(
  colorScheme: _copticColorScheme,
  scaffoldBackgroundColor: const Color(0xFF1E2535),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: Color(0xFF1B2030),
    foregroundColor: Color(0xFFE8ECFF),
  ),
);
