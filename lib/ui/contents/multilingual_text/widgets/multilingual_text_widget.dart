import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pimankagom/models/contents/multilingual_text.dart';
import 'package:pimankagom/ui/contents/multilingual_text/states/languages/languages_provider.dart';
import 'package:pimankagom/ui/contents/multilingual_text/widgets/text_widget.dart';

class MultilingualTextWidget extends ConsumerWidget {
  final MultilingualText multilingualText;

  const MultilingualTextWidget({super.key, required this.multilingualText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(languagesProvider);

    return Row(
      children: state.selectedLanguages
          .where((lang) => multilingualText.texts.containsKey(lang))
          .map((lang) => TextWidget(text: multilingualText.texts[lang]!, language: lang))
          .toList(),
    );
  }
}
