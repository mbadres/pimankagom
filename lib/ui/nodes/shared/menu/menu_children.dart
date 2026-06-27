import 'package:flutter/material.dart';
import 'package:pimankagom/constants/spacing.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/ui/nodes/shared/menu/menu_tile.dart';

class MenuChildren extends StatelessWidget {
  final Node node;

  const MenuChildren({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    final children = node.children.expand((group) => group).toList();

    return Expanded(
      child: ListView.builder(
        itemCount: children.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(spacing),
          child: MenuTile(node: children[index]),
        ),
      ),
    );
  }
}
