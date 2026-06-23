import 'package:flutter/material.dart';
import 'package:pimankagom/constants/spacing.dart';
import 'package:pimankagom/ui/nodes/selector.dart';
import 'package:pimankagom/ui/nodes/shared/header/header.dart';
import 'package:pimankagom/ui/nodes/shared/pager/pager.dart';
import 'package:pimankagom/ui/shared/parchment_background.dart';

class PagerState extends State<Pager> {
  late final PageController _controller;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _controller.addListener(_onPageChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onPageChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onPageChanged() {
    final page = _controller.page?.round();
    if (page != null && page != _index) {
      setState(() => _index = page);
    }
  }

  void _previous() {
    _controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void _next() {
    _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.node.children.length;

    return Scaffold(
      appBar: Header(node: widget.node),
      body: ParchmentBackground(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(spacing),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _index > 0 ? _previous : null,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: spacing),
                child: PageView.builder(
                  controller: _controller,
                  itemCount: total,
                  itemBuilder: (context, index) =>
                      Selector(node: widget.node.children[index].first),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(spacing),
              child: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: _index < total - 1 ? _next : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
