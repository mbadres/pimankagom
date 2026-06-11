import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/models/nodes/book.dart';
import 'package:pimankagom/models/nodes/chapter.dart';
import 'package:pimankagom/models/nodes/clause.dart';
import 'package:pimankagom/models/nodes/collection.dart';
import 'package:pimankagom/models/nodes/library.dart';
import 'package:pimankagom/models/nodes/paragraph.dart' as model;
import 'package:pimankagom/models/nodes/part.dart';
import 'package:pimankagom/models/nodes/section.dart';
import 'package:pimankagom/ui/configurations/settings/states/settings_provider.dart';
import 'package:pimankagom/ui/nodes/clause_node.dart';
import 'package:pimankagom/ui/nodes/navigated_slides.dart';
import 'package:pimankagom/ui/nodes/paragraph.dart';
import 'package:pimankagom/ui/nodes/shared/collapsible/collapsible.dart';
import 'package:pimankagom/ui/nodes/shared/menu/menu.dart';
import 'package:pimankagom/ui/nodes/shared/scroll/scroll.dart';
import 'package:pimankagom/ui/nodes/slides.dart';

class Selector extends ConsumerWidget {
  final Node node;
  final String? language;

  const Selector({super.key, required this.node, this.language});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsProvider);
    final isSlide = settingsAsync.maybeWhen(
      data: (settings) => settings.getSetting('view').currentValue == 'slide',
      orElse: () => false,
    );

    if (node is Library) {
      return Menu(node: node);
    } else if (node is Collection) {
      return Menu(node: node);
    } else if (node is Book) {
      return Menu(node: node);
    } else if (node is Part) {
      return Menu(node: node);
    } else if (node is Chapter) {
      return isSlide ? NavigatedSlides(node: node) : Scroll(node: node);
    } else if (node is Section) {
      return isSlide ? Slides(node: node) : Collapsible(node: node);
    } else if (node is model.Paragraph) {
      return Paragraph(node: node);
    } else if (node is Clause && language != null) {
      return ClauseNode(node: node, language: language!);
    }

    return Center(child: Text('Type ${node.runtimeType} not supported yet'));
  }
}
