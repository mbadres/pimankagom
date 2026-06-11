import 'package:flutter/material.dart';
import 'package:pimankagom/constants/spacing.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/ui/nodes/selector.dart';
import 'package:pimankagom/ui/nodes/shared/header/header.dart';

class Scroll extends StatelessWidget {
  final Node node;

  const Scroll({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    final sections = node.children.expand((group) => group).toList();

    return Scaffold(
      appBar: Header(node: node),
      body: ListView(
        children: sections
            .map(
              (section) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2 * spacing, horizontal: spacing),
                child: Selector(node: section),
              ),
            )
            .toList(),
      ),
    );
  }
}
