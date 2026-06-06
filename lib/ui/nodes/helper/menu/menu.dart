import 'package:flutter/material.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/ui/configurations/settings/widgets/settings.dart';
import 'package:pimankagom/ui/nodes/helper/header/header.dart';
import 'package:pimankagom/ui/nodes/helper/menu/menu_children.dart';

class Menu extends StatelessWidget {
  final Node node;

  const Menu({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(node: node),
      body: MenuChildren(node: node),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Scaffold(
              appBar: AppBar(title: const Text('Settings')),
              body: const Settings(),
            ),
          ),
        ),
        child: const Icon(Icons.settings),
      ),
    );
  }
}
