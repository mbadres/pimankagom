import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pimankagom/models/contents/multilingual_text.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/ui/contents/multilingual_text/states/languages/languages_provider.dart';
import 'package:pimankagom/ui/contents/multilingual_text/states/text_size/text_size_provider.dart';
import 'package:pimankagom/ui/contents/multilingual_text/widgets/text_widget.dart' show textStyleForLanguage;

class ParagraphNode extends ConsumerWidget {
  final Node node;

  const ParagraphNode({super.key, required this.node});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final multilingualText = node.value as MultilingualText;
    final clauses = node.children.expand((group) => group).toList();
    final languages = ref.watch(languagesProvider);
    final scale = ref.watch(textSizeProvider).scale;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: languages.selectedLanguages
            .where((lang) => multilingualText.texts.containsKey(lang))
            .map((lang) {
              final text = multilingualText.texts[lang]!;
              final isArabic = lang == 'arabic';
              return Expanded(
                child: Directionality(
                  textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text.rich(
                      TextSpan(
                        style: textStyleForLanguage(lang, scale: scale),
                        children: [
                          TextSpan(
                            text: '${text.value} ',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          ...clauses.map((clause) {
                            final clauseText = (clause.value as MultilingualText).texts[lang];
                            return TextSpan(text: '${clauseText?.value ?? ''} ');
                          }),
                        ],
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              );
            })
            .toList(),
      ),
    );
  }
}
