import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pimankagom/constants/spacing.dart';
import 'package:pimankagom/constants/velocity.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/ui/nodes/selector.dart';
import 'package:pimankagom/ui/nodes/shared/headline/headline.dart';
import 'package:pimankagom/ui/nodes/shared/slides/slides.dart';

class SlidesState extends State<Slides> {
  final GlobalKey _contentKey = GlobalKey();
  final FocusNode _focusNode = FocusNode();

  late final List<Node> _children;
  final List<int> _pageStarts = [0];
  int _pageIndex = 0;
  int _end = 0;
  bool _settled = false;
  double? _settledHeight;

  int get _start => _pageStarts[_pageIndex];

  @override
  void initState() {
    super.initState();
    _children = widget.node.children.expand((group) => group).toList();
    _end = _children.isEmpty ? 0 : _start + 1;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _resetGrowth() {
    _settled = false;
    _end = _children.isEmpty ? _start : _start + 1;
  }

  void _next() {
    if (_end >= _children.length) return;
    setState(() {
      if (_pageIndex + 1 >= _pageStarts.length) {
        _pageStarts.add(_end);
      }
      _pageIndex += 1;
      _resetGrowth();
    });
  }

  void _previous() {
    if (_pageIndex == 0) return;
    setState(() {
      _pageIndex -= 1;
      _resetGrowth();
    });
  }

  void _grow(double maxHeight) {
    if (!mounted) return;

    if (_settled) {
      if (maxHeight == _settledHeight) return;
      _settled = false;
    }

    final box = _contentKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return;

    if (box.size.height > maxHeight) {
      setState(() {
        if (_end > _start + 1) _end -= 1;
        _settled = true;
        _settledHeight = maxHeight;
      });
      return;
    }

    if (_end < _children.length) {
      setState(() => _end += 1);
    } else {
      _settled = true;
      _settledHeight = maxHeight;
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: (event) {
        if (event is! KeyDownEvent) return;
        if (event.logicalKey == LogicalKeyboardKey.arrowRight) _next();
        if (event.logicalKey == LogicalKeyboardKey.arrowLeft) _previous();
      },
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          final velocity = details.primaryVelocity ?? 0;
          if (velocity < -minVelocity) _next();
          if (velocity > minVelocity) _previous();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: spacing,
          children: [
            Headline(node: widget.node),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  WidgetsBinding.instance.addPostFrameCallback((_) => _grow(constraints.maxHeight));

                  return ClipRect(
                    child: OverflowBox(
                      alignment: Alignment.topLeft,
                      maxHeight: double.infinity,
                      child: Column(
                        key: _contentKey,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: spacing,
                        children: [
                          for (var i = _start; i < _end; i++) Selector(node: _children[i]),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
