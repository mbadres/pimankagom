import 'package:flutter/material.dart';
import 'package:pimankagom/constants/spacing.dart';

class Accent extends StatelessWidget {
  final Widget child;

  const Accent({super.key, this.child = const SizedBox()});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surfaceDim,
            border: Border(bottom: BorderSide(color: colorScheme.onPrimaryContainer, width: 2)),
          ),
          child: SizedBox(height: spacing * 2, child: child),
        ),
      ],
    );
  }
}
