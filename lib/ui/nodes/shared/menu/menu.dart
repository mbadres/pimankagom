import 'package:flutter/material.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/ui/nodes/shared/menu/menu_children.dart';
import 'package:pimankagom/ui/nodes/shared/menu/menu_header.dart';
import 'package:pimankagom/ui/nodes/shared/navigation/opener.dart';
import 'package:pimankagom/ui/shared/accent.dart';
import 'package:pimankagom/ui/shared/parchment_background.dart';

class Menu extends StatelessWidget {
  final Node node;

  const Menu({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ParchmentBackground(
        child: Column(
          children: [
            Accent(),
            MenuHeader(node: node),

            MenuChildren(node: node),
          ],
        ),
      ),
      floatingActionButton: Opener(node: node),
    );
  }
}
