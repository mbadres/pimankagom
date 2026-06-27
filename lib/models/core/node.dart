import 'package:pimankagom/models/contents/multilingual_text.dart';
import 'package:pimankagom/models/core/content.dart';
import 'package:pimankagom/models/nodes/book.dart';
import 'package:pimankagom/models/nodes/chapter.dart';
import 'package:pimankagom/models/nodes/clause.dart';
import 'package:pimankagom/models/nodes/collection.dart';
import 'package:pimankagom/models/nodes/library.dart';
import 'package:pimankagom/models/nodes/paragraph.dart';
import 'package:pimankagom/models/nodes/part.dart';
import 'package:pimankagom/models/nodes/section.dart';

interface class Node {
  final String id;
  // final List<Node> users;
  final Content value;
  final List<List<Node>> children;

  const Node({
    required this.id,
    // required this.users,
    required this.value,
    required this.children,
  });
}

Node nodeFromJson(Map<String, dynamic> json) {
  final id = json['id'] as String;
  final value = MultilingualText.fromJson(json['value'] as Map<String, dynamic>);
  final children = _childrenFromJson(json);

  switch (json['type']) {
    case 'library':
      return Library(id: id, value: value, children: children);
    case 'collection':
      return Collection(id: id, value: value, children: children);
    case 'book':
      return Book(id: id, value: value, children: children);
    case 'part':
      return Part(id: id, value: value, children: children);
    case 'chapter':
      return Chapter(id: id, value: value, children: children);
    case 'section':
      return Section(id: id, value: value, children: children);
    case 'paragraph':
      return Paragraph(id: id, value: value, children: children);
    case 'clause':
      return Clause(id: id, value: value, children: children);
    default:
      throw StateError('Unknown node type: ${json['type']}');
  }
}

List<List<Node>> _childrenFromJson(Map<String, dynamic> json) {
  final groups = (json['children'] as List?) ?? [];

  return groups
      .map((group) => (group as List).map((child) => nodeFromJson(child as Map<String, dynamic>)).toList())
      .toList();
}
