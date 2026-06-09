import 'package:flutter/material.dart';
import 'package:pimankagom/models/contents/multilingual_text.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/ui/contents/multilingual_text/widgets/unilingual_text_widget.dart';

class HeadlineWidget extends StatelessWidget {
  final Node node;

  const HeadlineWidget({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    return UnilingualTextWidget(multilingualText: node.value as MultilingualText);
  }
}
