import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pimankagom/models/contents/multilingual_text.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/ui/contents/multilingual_text/states/languages/languages_provider.dart';
import 'package:pimankagom/ui/contents/multilingual_text/states/text_size/text_size_provider.dart';
import 'package:pimankagom/ui/contents/multilingual_text/widgets/text_widget.dart';

class Headline extends ConsumerWidget {
  final Node node;

  const Headline({super.key, required this.node});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(languagesProvider).primaryLanguage;
    final isRtl = language == 'arabic';

    final languages = ref.watch(languagesProvider);
    final multilingualText = node.value as MultilingualText;
    final text = multilingualText.texts[languages.primaryLanguage];

    if (text == null) {
      return const SizedBox.shrink();
    }

    final scale = ref.watch(textSizeProvider).scale;
    final baseSize = Theme.of(context).textTheme.titleLarge?.fontSize ?? 14.0;

    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: DefaultTextStyle.merge(
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge,
        child: Text.rich(
          formattedText(text, languages.primaryLanguage, scale: scale, baseSize: baseSize),
        ),
      ),
    );
  }
}
