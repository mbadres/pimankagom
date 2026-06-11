import 'package:flutter/material.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/ui/nodes/shared/navigation/guide.dart';

class Opener extends StatelessWidget {
  final Node node;

  const Opener({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => Guide(node: node))),
      child: const Icon(Icons.settings),
    );
  }
}
