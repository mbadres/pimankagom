import 'package:flutter/material.dart';
import 'package:pimankagom/constants/spacing.dart';
import 'package:pimankagom/models/contents/multilingual_text.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/ui/contents/multilingual_text/widgets/unilingual_text_widget.dart';
import 'package:pimankagom/ui/nodes/selector.dart';
import 'package:pimankagom/ui/shared/director.dart';
import 'package:pimankagom/ui/shared/tile.dart';

class MenuTile extends StatelessWidget {
  final Node node;

  const MenuTile({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    return Director(
      child: Tile(
        onTap: () =>
            Navigator.push(context, MaterialPageRoute(builder: (_) => Selector(node: node))),
        child: Padding(
          padding: const EdgeInsets.all(spacing * 2),
          child: UnilingualTextWidget(multilingualText: node.value as MultilingualText),
        ),
      ),
    );
  }
}
