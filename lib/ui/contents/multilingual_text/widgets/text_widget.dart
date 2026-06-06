import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pimankagom/models/contents/text.dart' as model;
import 'package:pimankagom/ui/contents/multilingual_text/states/text_size/text_size_provider.dart';

class TextWidget extends ConsumerWidget {
  final model.Text text;
  final String language;

  const TextWidget({super.key, required this.text, required this.language});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scale = ref.watch(textSizeProvider).scale;
    return Text(text.value, style: textStyleForLanguage(language, scale: scale));
  }
}

TextStyle textStyleForLanguage(String language, {double scale = 1.0}) => switch (language) {
  'coptic' => TextStyle(fontFamily: 'Athanasius', fontSize: 22 * scale),
  'arabic' => TextStyle(fontFamily: 'Scheherazade', fontSize: 24 * scale),
  _ => TextStyle(fontFamily: 'Garamond', fontSize: 20 * scale),
};
