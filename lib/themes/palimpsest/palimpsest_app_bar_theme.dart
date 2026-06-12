import 'package:flutter/material.dart';
import 'package:pimankagom/themes/palimpsest/palimpsest_color_scheme.dart';
import 'package:pimankagom/themes/palimpsest/palimpsest_text_theme.dart';

final palimpsestAppBarTheme = AppBarTheme(
  centerTitle: true,
  scrolledUnderElevation: 0,
  backgroundColor: palimpsestColorScheme.surfaceDim,
  foregroundColor: palimpsestColorScheme.secondary,
  titleTextStyle: palimpsestTextTheme.titleLarge,
  shape: Border(bottom: BorderSide(color: palimpsestColorScheme.outlineVariant)),
);
