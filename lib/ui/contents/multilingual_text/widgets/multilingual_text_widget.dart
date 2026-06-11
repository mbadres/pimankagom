import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pimankagom/models/contents/multilingual_text.dart';
import 'package:pimankagom/ui/contents/multilingual_text/states/languages/languages_provider.dart';
import 'package:pimankagom/ui/contents/multilingual_text/states/text_size/text_size_provider.dart';
import 'package:pimankagom/ui/contents/multilingual_text/widgets/text_widget.dart';

class MultilingualTextWidget extends ConsumerWidget {
  final MultilingualText multilingualText;

  const MultilingualTextWidget({super.key, required this.multilingualText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(languagesProvider);
    final scale = ref.watch(textSizeProvider).scale;
    final baseSize = Theme.of(context).textTheme.bodyMedium?.fontSize ?? 14.0;

    return Row(
      children: state.selectedLanguages
          .where((lang) => multilingualText.texts.containsKey(lang))
          .map(
            (lang) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text.rich(formattedText(multilingualText.texts[lang]!, lang, scale: scale, baseSize: baseSize)),
            ),
          )
          .toList(),
    );
  }
}
