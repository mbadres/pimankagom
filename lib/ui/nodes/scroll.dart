import 'package:flutter/material.dart';
import 'package:pimankagom/models/contents/multilingual_text.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/ui/contents/multilingual_text/widgets/unilingual_text_widget.dart';
import 'package:pimankagom/ui/nodes/selector.dart';

class Scroll extends StatelessWidget {
  final Node node;

  const Scroll({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: UnilingualTextWidget(multilingualText: node.value as MultilingualText)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: node.children
            .expand((group) => group)
            .map((child) => Selector(node: child))
            .toList(),
      ),
    );
  }
}
