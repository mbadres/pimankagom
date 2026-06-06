import 'package:flutter/material.dart';
import 'package:pimankagom/models/contents/multilingual_text.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/ui/contents/multilingual_text/widgets/unilingual_text_widget.dart';
import 'package:pimankagom/ui/nodes/paragraph_node.dart';

class NavigatedSlides extends StatefulWidget {
  final Node node;

  const NavigatedSlides({super.key, required this.node});

  @override
  State<NavigatedSlides> createState() => _NavigatedSlidesState();
}

class _NavigatedSlidesState extends State<NavigatedSlides> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _previous() {
    if (_controller.page != null && _controller.page! > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.maybePop(context);
    }
  }

  void _next(int total) {
    if (_controller.page != null && _controller.page! < total - 1) {
      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      Navigator.maybePop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sections = widget.node.children.expand((group) => group).toList();

    return Scaffold(
      appBar: AppBar(
        title: UnilingualTextWidget(multilingualText: widget.node.value as MultilingualText),
        actions: [
          IconButton(icon: const Icon(Icons.arrow_back), tooltip: 'Previous', onPressed: _previous),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            tooltip: 'Next',
            onPressed: () => _next(sections.length),
          ),
        ],
      ),
      body: PageView.builder(
        controller: _controller,
        itemCount: sections.length,
        itemBuilder: (context, index) {
          final section = sections[index];
          final paragraphs = section.children.expand((group) => group).toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: UnilingualTextWidget(multilingualText: section.value as MultilingualText),
                ),
                ...paragraphs.map((paragraph) => ParagraphNode(node: paragraph)),
              ],
            ),
          );
        },
      ),
    );
  }
}
