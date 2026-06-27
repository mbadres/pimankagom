import 'package:pimankagom/models/contents/text.dart';
import 'package:pimankagom/models/core/content.dart';

class MultilingualText implements Content {
  @override
  final String id;

  final Map<String, Text> texts;

  const MultilingualText({required this.id, required this.texts});

  factory MultilingualText.fromJson(Map<String, dynamic> json) {
    final texts = json['texts'] as Map<String, dynamic>;

    return MultilingualText(
      id: json['id'] as String,
      texts: texts.map((language, text) => MapEntry(language, Text.fromJson(text as Map<String, dynamic>))),
    );
  }
}
