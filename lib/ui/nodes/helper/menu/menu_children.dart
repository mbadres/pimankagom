import 'package:flutter/material.dart';
import 'package:pimankagom/models/contents/multilingual_text.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/ui/contents/multilingual_text/widgets/unilingual_text_widget.dart';
import 'package:pimankagom/ui/nodes/selector.dart';

class MenuChildren extends StatelessWidget {
  final Node node;

  const MenuChildren({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: node.children
          .expand((group) => group)
          .map(
            (child) => ListTile(
              title: UnilingualTextWidget(multilingualText: child.value as MultilingualText),
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (_) => Selector(node: child))),
            ),
          )
          .toList(),
    );
  }
}
