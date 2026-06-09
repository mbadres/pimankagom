import 'package:flutter/material.dart';
import 'package:pimankagom/models/contents/multilingual_text.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/ui/contents/multilingual_text/widgets/unilingual_text_widget.dart';
import 'package:pimankagom/ui/nodes/selector.dart';

class ScrollWidget extends StatelessWidget {
  final Node node;

  const ScrollWidget({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    final sections = node.children.expand((group) => group).toList();

    return Scaffold(
      appBar: AppBar(
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              )
            : Builder(
                builder: (ctx) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(ctx).openDrawer(),
                ),
              ),
        title: UnilingualTextWidget(multilingualText: node.value as MultilingualText),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: sections.map((section) => Selector(node: section)).toList(),
      ),
    );
  }
}
