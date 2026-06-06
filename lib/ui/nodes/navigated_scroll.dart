import 'package:flutter/material.dart';
import 'package:pimankagom/models/contents/multilingual_text.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/ui/contents/multilingual_text/widgets/unilingual_text_widget.dart';
import 'package:pimankagom/ui/nodes/paragraph_node.dart';
import 'package:pimankagom/ui/nodes/selector.dart';

class NavigatedScroll extends StatelessWidget {
  final Node node;

  const NavigatedScroll({super.key, required this.node});

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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: UnilingualTextWidget(multilingualText: node.value as MultilingualText),
            ),
            ...sections.map(
              (section) => ListTile(
                title: UnilingualTextWidget(multilingualText: section.value as MultilingualText),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Selector(node: section)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: sections.expand((section) {
          final paragraphs = section.children.expand((group) => group).toList();
          return <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: UnilingualTextWidget(multilingualText: section.value as MultilingualText),
            ),
            ...paragraphs.map((paragraph) => ParagraphNode(node: paragraph)),
          ];
        }).toList(),
      ),
    );
  }
}
