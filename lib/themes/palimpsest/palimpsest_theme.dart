import 'package:flutter/material.dart';
import 'package:pimankagom/themes/basic/basic_theme.dart';
import 'package:pimankagom/themes/palimpsest/palimpsest_color_scheme.dart';

final ThemeData palimpsestLightTheme = basicLightTheme.copyWith(
  colorScheme: palimpsestColorScheme,
  // textTheme: palimpsestTextTheme,
  // scaffoldBackgroundColor: _parchment,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    // backgroundColor: _parchment,
    // foregroundColor: _ink,
    // shadowColor: _rule,
    // scrolledUnderElevation: 1,
    // elevation: 0,
  ),
  navigationBarTheme: NavigationBarThemeData(
    labelTextStyle: WidgetStateTextStyle.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const TextStyle(fontWeight: FontWeight.bold);
      }
      return const TextStyle(fontWeight: FontWeight.normal);
    }),
  ),
);

final ThemeData palimpsestDarkTheme = basicDarkTheme;
