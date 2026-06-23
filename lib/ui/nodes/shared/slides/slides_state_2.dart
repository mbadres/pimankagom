import 'package:flutter/material.dart';
import 'package:pimankagom/constants/spacing.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/ui/nodes/selector.dart';
import 'package:pimankagom/ui/nodes/shared/headline/headline.dart';
import 'package:pimankagom/ui/nodes/shared/slides/slides.dart';

class SlidesState extends State<Slides> {
  late final List<Node> _children;
  late final List<GlobalKey> _measureKeys;
  int _visibleCount = 0;

  @override
  void initState() {
    super.initState();
    _children = widget.node.children.expand((group) => group).toList();
    _measureKeys = List.generate(_children.length, (_) => GlobalKey());
  }

  void _fitToHeight(double availableHeight) {
    var used = 0.0;
    var fitCount = 0;

    for (var i = 0; i < _children.length; i++) {
      final box = _measureKeys[i].currentContext?.findRenderObject() as RenderBox?;
      if (box == null) break;

      used += box.size.height + (i == 0 ? 0 : spacing);
      if (used > availableHeight) break;
      fitCount = i + 1;
    }

    if (fitCount != _visibleCount && mounted) {
      setState(() => _visibleCount = fitCount);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: spacing,
      children: [
        Headline(node: widget.node),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => _fitToHeight(constraints.maxHeight),
              );

              return Stack(
                children: [
                  Offstage(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: spacing,
                      children: [
                        for (var i = 0; i < _children.length; i++)
                          KeyedSubtree(
                            key: _measureKeys[i],
                            child: Selector(node: _children[i]),
                          ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: spacing,
                    children: _children
                        .take(_visibleCount)
                        .map((child) => Selector(node: child))
                        .toList(),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
