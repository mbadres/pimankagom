import 'package:flutter/material.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/ui/nodes/helper/navigation/navigator.dart';

class Opener extends StatelessWidget {
  final Node node;

  const Opener({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => Navigatorr(node: node))),
      child: const Icon(Icons.settings),
    );
  }
}
