import 'package:flutter/material.dart';
import 'package:pimankagom/constants/spacing.dart';

class Tile extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const Tile({super.key, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(spacing),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: onTap != null ? InkWell(onTap: onTap, child: child) : child,
    );
  }
}
