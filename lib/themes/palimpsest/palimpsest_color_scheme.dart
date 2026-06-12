import 'package:flutter/material.dart';

const _butter = Color(0xFFF3DE9C);
const _butterDeep = Color(0xFFE7CD7C);
const _ink = Color(0xFF2C2418);
const _inkSoft = Color(0xFF5C5341);
const _inkFaint = Color(0xFF8A7E66);
const _rule = Color(0xFFD8C99B);
const _goldSoft = Color(0xFFD8B25E);
const _gold = Color(0xFFB4863A);

// Bordeaux scale
const _bordeaux50 = Color(0xFFF0DADC);
const _bordeaux200 = Color(0xFFD9A7AB);
const _bordeaux400 = Color(0xFFB66A6F);
const _bordeauxTint = Color(0xFF9C4A4E);
const _bordeaux = Color(0xFF7C2A33);
const _oxblood = Color(0xFF561C24);

// Sage / Parchment scale
const _parchment = Color(0xFFFBF4DE);
const _parchment2 = Color(0xFFF6EBC9);
const _sage100 = Color(0xFFEDE7C4);
const _sage200 = Color(0xFFD8D3A4);
const _sageSoft = Color(0xFFB7B488);
const _sage = Color(0xFF8C8C58);
const _oliveDeep = Color(0xFF5E5E38);

// Error (Material defaults)
const _scarlet = Color(0xFFB3261E);
const _white = Color(0xFFFFFFFF);
const _blush = Color(0xFFF9DEDC);
const _garnet = Color(0xFF410E0B);

// Misc
const _black = Color(0xFF000000);

// Interpolated (not in style guide, needed for Material surface hierarchy)
const _parchmentSoft = Color(0xFFFFFDF5);
const _butterMid = Color(0xFFF0E2B8);
const _butterWarm = Color(0xFFEDD9A8);
const _goldLight = Color(0xFFF5EAD0);
const _goldDeep = Color(0xFF6B4C1A);

final ColorScheme palimpsestColorScheme = ColorScheme(
  brightness: Brightness.light,
  // surfaces
  surface: _parchment,
  surfaceDim: _parchment2,
  surfaceBright: _parchmentSoft,
  surfaceContainerLowest: _parchmentSoft,
  surfaceContainerLow: _parchment2,
  surfaceContainer: _butterMid,
  surfaceContainerHigh: _butterWarm,
  surfaceContainerHighest: _butterDeep,
  surfaceTint: _parchment,
  onSurface: _ink,
  onSurfaceVariant: _inkSoft,
  inverseSurface: _ink,
  onInverseSurface: _parchment,

  // primary — bordeaux
  primary: _bordeaux,
  onPrimary: _parchment,
  primaryContainer: _bordeaux50,
  onPrimaryContainer: _oxblood,
  primaryFixed: _bordeaux50,
  primaryFixedDim: _bordeaux200,
  onPrimaryFixed: _garnet,
  onPrimaryFixedVariant: _oxblood,
  inversePrimary: _bordeauxTint,

  // secondary — sage / olive
  secondary: _sage,
  onSecondary: _parchment,
  secondaryContainer: _sage100,
  onSecondaryContainer: _oliveDeep,
  secondaryFixed: _sage100,
  secondaryFixedDim: _sage200,
  onSecondaryFixed: _ink,
  onSecondaryFixedVariant: _oliveDeep,

  // tertiary — gold
  tertiary: _gold,
  onTertiary: _parchment,
  tertiaryContainer: _goldLight,
  onTertiaryContainer: _goldDeep,
  tertiaryFixed: _goldLight,
  tertiaryFixedDim: _goldSoft,
  onTertiaryFixed: _goldDeep,
  onTertiaryFixedVariant: _gold,

  // error
  error: _scarlet,
  onError: _white,
  errorContainer: _blush,
  onErrorContainer: _garnet,

  // outlines
  outline: _inkFaint,
  outlineVariant: _rule,

  shadow: _black,
  scrim: _black,
);
