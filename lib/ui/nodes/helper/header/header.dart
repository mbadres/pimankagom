import 'package:flutter/material.dart';
import 'package:pimankagom/models/contents/multilingual_text.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/ui/contents/multilingual_text/widgets/unilingual_text_widget.dart';

class Header extends AppBar {
  final Node node;

  Header({super.key, required this.node})
    : super(title: UnilingualTextWidget(multilingualText: node.value as MultilingualText));
}
