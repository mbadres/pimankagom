import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/states/content/chapter_provider.dart';
import 'package:pimankagom/ui/nodes/shared/pager/pager.dart';
import 'package:pimankagom/ui/nodes/shared/scroll/scroll.dart';

class ChapterLoader extends ConsumerWidget {
  final Node node;
  final bool isSlide;

  const ChapterLoader({super.key, required this.node, required this.isSlide});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chapterAsync = ref.watch(chapterProvider(node.id));

    return chapterAsync.when(
      data: (chapter) => isSlide ? Pager(node: chapter) : Scroll(node: chapter),
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stackTrace) => Scaffold(body: Center(child: Text('$error'))),
    );
  }
}
