import 'package:flutter/material.dart';
import 'package:pimankagom/constants/spacing.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/ui/nodes/shared/children/children_list.dart';
import 'package:pimankagom/ui/nodes/shared/headline/headline.dart';

class Collapsible extends StatelessWidget {
  final Node node;

  const Collapsible({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: spacing,
      children: [
        Headline(node: node),
        ChildrenList(node: node),
      ],
    );
  }
}
