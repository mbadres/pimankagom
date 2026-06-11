import 'package:flutter/material.dart';
import 'package:pimankagom/themes/basic_theme.dart';

const Color _highContrastBlack = Color(0xFF000000);
const Color _highContrastWhite = Color(0xFFFFFFFF);
const Color _highContrastBlue = Color(0xFF0000FF);
const Color _highContrastRed = Color(0xFFFF0000);
const Color _highContrastYellow = Color(0xFFFFFF00);

final ThemeData contrastModeLightTheme = basicLightTheme.copyWith(
  brightness: Brightness.light,

  // Color scheme with maximum contrast
  colorScheme: const ColorScheme.light(
    primary: _highContrastBlack,
    secondary: _highContrastBlue,
    onSecondary: _highContrastWhite,
    error: _highContrastRed,
    outline: _highContrastBlack,
    outlineVariant: _highContrastBlack,
  ),

  // AppBar theme
  appBarTheme: const AppBarTheme(
    backgroundColor: _highContrastBlack,
    foregroundColor: _highContrastWhite,
    elevation: 8,
    shadowColor: _highContrastBlack,
    titleTextStyle: TextStyle(color: _highContrastWhite, fontSize: 20, fontWeight: FontWeight.bold),
  ),

  // Text theme with high contrast
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: _highContrastBlack, fontWeight: FontWeight.bold, fontSize: 57),
    displayMedium: TextStyle(color: _highContrastBlack, fontWeight: FontWeight.bold, fontSize: 45),
    displaySmall: TextStyle(color: _highContrastBlack, fontWeight: FontWeight.bold, fontSize: 36),
    headlineLarge: TextStyle(color: _highContrastBlack, fontWeight: FontWeight.bold, fontSize: 32),
    headlineMedium: TextStyle(color: _highContrastBlack, fontWeight: FontWeight.bold, fontSize: 28),
    headlineSmall: TextStyle(color: _highContrastBlack, fontWeight: FontWeight.bold, fontSize: 24),
    titleLarge: TextStyle(color: _highContrastBlack, fontWeight: FontWeight.bold, fontSize: 22),
    titleMedium: TextStyle(color: _highContrastBlack, fontWeight: FontWeight.w600, fontSize: 16),
    titleSmall: TextStyle(color: _highContrastBlack, fontWeight: FontWeight.w600, fontSize: 14),
    bodyLarge: TextStyle(color: _highContrastBlack, fontSize: 16, fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(color: _highContrastBlack, fontSize: 14, fontWeight: FontWeight.w500),
    bodySmall: TextStyle(color: _highContrastBlack, fontSize: 12, fontWeight: FontWeight.w500),
    labelLarge: TextStyle(color: _highContrastBlack, fontSize: 14, fontWeight: FontWeight.bold),
    labelMedium: TextStyle(color: _highContrastBlack, fontSize: 12, fontWeight: FontWeight.bold),
    labelSmall: TextStyle(color: _highContrastBlack, fontSize: 11, fontWeight: FontWeight.bold),
  ),

  // Button themes
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _highContrastBlack,
      foregroundColor: _highContrastWhite,
      elevation: 8,
      shadowColor: _highContrastBlack,
      side: const BorderSide(width: 2),
      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: _highContrastBlack,
      side: const BorderSide(width: 3),
      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: _highContrastBlack,
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        decoration: TextDecoration.underline,
      ),
    ),
  ),

  // Card theme
  cardTheme: const CardThemeData(
    color: _highContrastWhite,
    elevation: 8,
    shadowColor: _highContrastBlack,
    surfaceTintColor: Colors.transparent,
  ),

  // Input decoration theme
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: _highContrastWhite,
    border: OutlineInputBorder(borderSide: BorderSide(width: 3)),
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 3)),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: _highContrastBlue, width: 4)),
    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: _highContrastRed, width: 3)),
    labelStyle: TextStyle(color: _highContrastBlack, fontWeight: FontWeight.bold),
    hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
  ),

  // Checkbox theme
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return _highContrastBlack;
      }
      return _highContrastWhite;
    }),
    checkColor: WidgetStateProperty.all(_highContrastWhite),
    side: const BorderSide(width: 3),
  ),

  // Switch theme
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return _highContrastBlack;
      }
      return _highContrastWhite;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return _highContrastWhite;
      }
      return _highContrastBlack;
    }),
    trackOutlineColor: WidgetStateProperty.all(_highContrastBlack),
    trackOutlineWidth: WidgetStateProperty.all(3),
  ),

  // Divider theme
  dividerTheme: const DividerThemeData(color: _highContrastBlack, thickness: 2),

  // Bottom navigation bar theme
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: _highContrastBlack,
    selectedItemColor: _highContrastWhite,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  ),
);

final contrastModeDarkTheme = basicDarkTheme.copyWith(
  brightness: Brightness.dark,

  // Color scheme with maximum contrast (inverted)
  colorScheme: const ColorScheme.dark(
    primary: _highContrastWhite,
    secondary: _highContrastYellow,
    surface: _highContrastBlack,
    error: _highContrastRed,
    onError: _highContrastWhite,
    outline: _highContrastWhite,
    outlineVariant: _highContrastWhite,
  ),

  // AppBar theme
  appBarTheme: const AppBarTheme(
    backgroundColor: _highContrastWhite,
    foregroundColor: _highContrastBlack,
    elevation: 8,
    shadowColor: _highContrastWhite,
    titleTextStyle: TextStyle(color: _highContrastBlack, fontSize: 20, fontWeight: FontWeight.bold),
  ),

  // Text theme with high contrast (inverted)
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: _highContrastWhite, fontWeight: FontWeight.bold, fontSize: 57),
    displayMedium: TextStyle(color: _highContrastWhite, fontWeight: FontWeight.bold, fontSize: 45),
    displaySmall: TextStyle(color: _highContrastWhite, fontWeight: FontWeight.bold, fontSize: 36),
    headlineLarge: TextStyle(color: _highContrastWhite, fontWeight: FontWeight.bold, fontSize: 32),
    headlineMedium: TextStyle(color: _highContrastWhite, fontWeight: FontWeight.bold, fontSize: 28),
    headlineSmall: TextStyle(color: _highContrastWhite, fontWeight: FontWeight.bold, fontSize: 24),
    titleLarge: TextStyle(color: _highContrastWhite, fontWeight: FontWeight.bold, fontSize: 22),
    titleMedium: TextStyle(color: _highContrastWhite, fontWeight: FontWeight.w600, fontSize: 16),
    titleSmall: TextStyle(color: _highContrastWhite, fontWeight: FontWeight.w600, fontSize: 14),
    bodyLarge: TextStyle(color: _highContrastWhite, fontSize: 16, fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(color: _highContrastWhite, fontSize: 14, fontWeight: FontWeight.w500),
    bodySmall: TextStyle(color: _highContrastWhite, fontSize: 12, fontWeight: FontWeight.w500),
    labelLarge: TextStyle(color: _highContrastWhite, fontSize: 14, fontWeight: FontWeight.bold),
    labelMedium: TextStyle(color: _highContrastWhite, fontSize: 12, fontWeight: FontWeight.bold),
    labelSmall: TextStyle(color: _highContrastWhite, fontSize: 11, fontWeight: FontWeight.bold),
  ),

  // Button themes (inverted)
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _highContrastWhite,
      foregroundColor: _highContrastBlack,
      elevation: 8,
      shadowColor: _highContrastWhite,
      side: const BorderSide(color: _highContrastWhite, width: 2),
      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: _highContrastWhite,
      side: const BorderSide(color: _highContrastWhite, width: 3),
      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: _highContrastWhite,
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        decoration: TextDecoration.underline,
      ),
    ),
  ),

  // Card theme (inverted)
  cardTheme: const CardThemeData(
    color: _highContrastBlack,
    elevation: 8,
    shadowColor: _highContrastWhite,
    surfaceTintColor: Colors.transparent,
  ),

  // Input decoration theme (inverted)
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: _highContrastBlack,
    border: OutlineInputBorder(borderSide: BorderSide(color: _highContrastWhite, width: 3)),
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: _highContrastWhite, width: 3)),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: _highContrastYellow, width: 4)),
    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: _highContrastRed, width: 3)),
    labelStyle: TextStyle(color: _highContrastWhite, fontWeight: FontWeight.bold),
    hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
  ),

  // Checkbox theme (inverted)
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return _highContrastWhite;
      }
      return _highContrastBlack;
    }),
    checkColor: WidgetStateProperty.all(_highContrastBlack),
    side: const BorderSide(color: _highContrastWhite, width: 3),
  ),

  // Switch theme (inverted)
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return _highContrastWhite;
      }
      return _highContrastBlack;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return _highContrastBlack;
      }
      return _highContrastWhite;
    }),
    trackOutlineColor: WidgetStateProperty.all(_highContrastWhite),
    trackOutlineWidth: WidgetStateProperty.all(3),
  ),

  // Divider theme (inverted)
  dividerTheme: const DividerThemeData(color: _highContrastWhite, thickness: 2),

  // Bottom navigation bar theme (inverted)
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: _highContrastWhite,
    selectedItemColor: _highContrastBlack,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  ),
);
