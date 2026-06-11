import 'package:flutter/material.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/ui/nodes/shared/header/header.dart';
import 'package:pimankagom/ui/nodes/shared/menu/menu_children.dart';
import 'package:pimankagom/ui/nodes/shared/navigation/opener.dart';

class Menu extends StatelessWidget {
  final Node node;

  const Menu({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(node: node),
      body: MenuChildren(node: node),
      floatingActionButton: Opener(node: node),
    );
  }
}
