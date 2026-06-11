import 'package:flutter/material.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/ui/nodes/selector.dart';

class ChildrenList extends StatelessWidget {
  final Node node;

  const ChildrenList({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: node.children
          .expand((group) => group)
          .map((child) => Selector(node: child))
          .toList(),
    );
  }
}
