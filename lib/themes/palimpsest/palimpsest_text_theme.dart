import 'package:flutter/material.dart';
import 'package:pimankagom/themes/palimpsest/palimpsest_color_scheme.dart';

const _baseTextStyle = TextStyle(fontFamily: 'Garamond');

final _heading = TextStyle(
  fontFamily: 'Garamond',
  fontWeight: FontWeight.w600,
  height: 1.08,
  color: palimpsestColorScheme.onPrimaryContainer,
);

final _body = TextStyle(
  fontFamily: 'Garamond',
  fontWeight: FontWeight.w400,
  color: palimpsestColorScheme.onSurface,
);

final _label = TextStyle(
  fontFamily: 'Garamond',
  fontWeight: FontWeight.w500,
  color: palimpsestColorScheme.secondary,
  fontFeatures: [FontFeature.enable('smcp')],
);

final palimpsestTextTheme = TextTheme(
  displayLarge: _heading.copyWith(fontSize: 57, letterSpacing: -0.25),
  displayMedium: _heading.copyWith(fontSize: 45),
  displaySmall: _heading.copyWith(fontSize: 36),
  headlineLarge: _heading.copyWith(fontSize: 32, letterSpacing: -0.3),
  headlineMedium: _heading.copyWith(fontSize: 28, letterSpacing: -0.3),
  headlineSmall: _heading.copyWith(fontSize: 24, color: palimpsestColorScheme.primary),
  titleLarge: _label.copyWith(fontSize: 22, height: 1.5),
  titleMedium: _label.copyWith(fontSize: 16),
  titleSmall: _label.copyWith(fontSize: 14),
  bodyLarge: _body.copyWith(fontSize: 18, height: 1.55),
  bodyMedium: _body.copyWith(fontSize: 16, height: 1.5),
  bodySmall: _body.copyWith(fontSize: 12),
  labelLarge: _label.copyWith(fontSize: 14, letterSpacing: 1.0),
  labelMedium: _label.copyWith(fontSize: 12, letterSpacing: 3.1),
  labelSmall: _label.copyWith(fontSize: 11, letterSpacing: 5.5),
);
