import 'package:flutter/material.dart';
import 'package:pimankagom/constants/spacing.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/ui/nodes/selector.dart';
import 'package:pimankagom/ui/shared/parchment_background.dart';

class Scroll extends StatelessWidget {
  final Node node;

  const Scroll({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    final sections = node.children.expand((group) => group).toList();

    return Scaffold(
      body: SafeArea(
        child: ParchmentBackground(
          child: ListView.builder(
            itemCount: sections.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2 * spacing, horizontal: spacing),
              child: Selector(node: sections[index]),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
