import 'package:flutter/material.dart';
import 'package:pimankagom/models/contents/multilingual_text.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/ui/contents/multilingual_text/widgets/text_widget.dart';

class ClauseNode extends StatelessWidget {
  final Node node;
  final String language;

  const ClauseNode({super.key, required this.node, required this.language});

  @override
  Widget build(BuildContext context) {
    final multilingualText = node.value as MultilingualText;
    final text = multilingualText.texts[language];

    if (text == null) {
      return Text('No text available for language: $language');
    }

    return TextWidget(text: text, language: language);
  }
}
