import 'package:pimankagom/models/core/content.dart';
import 'package:pimankagom/models/core/node.dart';

class Collection implements Node {
  @override
  final String id;

  // @override
  // final List<Node> users;

  @override
  final Content value;

  @override
  final List<List<Node>> children;

  const Collection({
    required this.id,
    // required this.users,
    required this.value,
    required this.children,
  });
}
