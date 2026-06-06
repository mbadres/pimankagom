import 'package:pimankagom/models/contents/text.dart';
import 'package:pimankagom/models/core/content.dart';

class MultilingualText implements Content {
  @override
  final String id;

  final Map<String, Text> texts;

  const MultilingualText({required this.id, required this.texts});
}
