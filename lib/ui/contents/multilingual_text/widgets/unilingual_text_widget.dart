import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pimankagom/models/contents/multilingual_text.dart';
import 'package:pimankagom/states/languages/languages_provider.dart';
import 'package:pimankagom/ui/contents/multilingual_text/states/text_size_provider.dart';
import 'package:pimankagom/ui/contents/multilingual_text/widgets/text_widget.dart';

class UnilingualTextWidget extends ConsumerWidget {
  final MultilingualText multilingualText;

  const UnilingualTextWidget({super.key, required this.multilingualText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languages = ref.watch(languagesProvider);
    final text = multilingualText.texts[languages.primaryLanguage];

    if (text == null) {
      return const SizedBox.shrink();
    }

    final scale = ref.watch(textSizeProvider).scale;
    final baseSize = Theme.of(context).textTheme.bodyMedium?.fontSize ?? 14.0;
    return Text.rich(
      formattedText(text, languages.primaryLanguage, scale: scale, baseSize: baseSize),
    );
  }
}

TextStyle textStyleForLanguage(String language, {double scale = 1.0, double baseSize = 14.0}) =>
    switch (language) {
      'coptic' => TextStyle(fontFamily: 'Athanasius' /*, fontSize: baseSize + 2 * scale*/),
      'arabic' => TextStyle(fontFamily: 'Scheherazade' /*, fontSize: baseSize + 4 * scale*/),
      _ => TextStyle(fontFamily: 'Garamond' /* fontSize: baseSize * scale*/),
    };
