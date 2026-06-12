import 'package:flutter/material.dart';
import 'package:pimankagom/models/contents/text.dart' as model;

TextSpan formattedText(
  model.Text text,
  String language, {
  double scale = 1.0,
  double baseSize = 14.0,
}) => TextSpan(
  text: text.value,
  style: textStyleForLanguage(language, scale: scale, baseSize: baseSize),
);

TextStyle textStyleForLanguage(String language, {double scale = 1.0, double baseSize = 14.0}) =>
    switch (language) {
      'coptic' => TextStyle(fontFamily: 'Athanasius' /*, fontSize: baseSize + 2 * scale*/),
      'arabic' => TextStyle(fontFamily: 'Scheherazade' /*, fontSize: baseSize + 4 * scale*/),
      _ => TextStyle(fontFamily: 'Garamond' /* fontSize: baseSize * scale*/),
    };
