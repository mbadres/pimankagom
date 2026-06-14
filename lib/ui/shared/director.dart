import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pimankagom/states/languages/languages_provider.dart';

class Director extends ConsumerWidget {
  final Widget child;

  const Director({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(languagesProvider).primaryLanguage;
    final isRightToLeft = language == 'arabic';

    return Directionality(
      textDirection: isRightToLeft ? TextDirection.rtl : TextDirection.ltr,
      child: child,
    );
  }
}
