import 'package:flutter/material.dart';
import 'package:pimankagom/constants/spacing.dart';
import 'package:pimankagom/models/contents/multilingual_text.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/ui/contents/multilingual_text/widgets/unilingual_text_widget.dart';
import 'package:pimankagom/ui/shared/director.dart';
import 'package:pimankagom/ui/shared/tile.dart';

class MenuHeader extends StatelessWidget {
  final Node node;

  const MenuHeader({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    return Director(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: spacing * 2, vertical: spacing * 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Navigator.canPop(context))
              Padding(
                padding: const EdgeInsetsDirectional.only(end: spacing),
                child: Tile(child: BackButton()),
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(spacing),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTextStyle.merge(
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.displayMedium,
                      child: UnilingualTextWidget(multilingualText: node.value as MultilingualText),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
