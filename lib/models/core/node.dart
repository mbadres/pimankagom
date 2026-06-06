import 'package:pimankagom/models/core/content.dart';

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
