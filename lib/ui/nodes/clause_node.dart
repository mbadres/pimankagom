import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pimankagom/models/contents/multilingual_text.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/ui/contents/multilingual_text/states/text_size/text_size_provider.dart';
import 'package:pimankagom/ui/contents/multilingual_text/widgets/text_widget.dart';

class ClauseNode extends ConsumerWidget {
  final Node node;
  final String language;

  const ClauseNode({super.key, required this.node, required this.language});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final multilingualText = node.value as MultilingualText;
    final text = multilingualText.texts[language];

    if (text == null) {
      return Text('No text available for language: $language');
    }

    final scale = ref.watch(textSizeProvider).scale;
    return Text.rich(formattedText(text, language, scale: scale));
  }
}
