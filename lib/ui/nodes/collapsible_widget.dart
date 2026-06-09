import 'package:flutter/material.dart';
import 'package:pimankagom/models/contents/multilingual_text.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/ui/contents/multilingual_text/widgets/unilingual_text_widget.dart';
import 'package:pimankagom/ui/nodes/selector.dart';

class CollapsibleWidget extends StatelessWidget {
  final Node node;

  const CollapsibleWidget({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        UnilingualTextWidget(multilingualText: node.value as MultilingualText),
        ...node.children.expand((group) => group).map((child) => Selector(node: child)),
      ],
    );
  }
}
