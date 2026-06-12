import 'package:flutter/material.dart';
import 'package:pimankagom/themes/basic/basic_theme.dart';
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

final ThemeData palimpsestDarkTheme = basicDarkTheme;
