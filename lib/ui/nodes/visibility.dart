import 'package:flutter/material.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/ui/nodes/selector.dart';

class Visibility extends StatelessWidget {
  final Node node;
  final String? language;

  const Visibility({super.key, required this.node, this.language});

  @override
  Widget build(BuildContext context) {
    return Selector(node: node, language: language);
  }
}
