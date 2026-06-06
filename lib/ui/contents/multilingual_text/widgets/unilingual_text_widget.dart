import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pimankagom/models/contents/multilingual_text.dart';
import 'package:pimankagom/ui/contents/multilingual_text/states/languages/languages_provider.dart';
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

    return TextWidget(text: text, language: languages.primaryLanguage);
  }
}
