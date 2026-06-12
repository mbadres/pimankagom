import 'package:flutter/material.dart';
import 'package:pimankagom/models/contents/multilingual_text.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/ui/contents/multilingual_text/widgets/unilingual_text_widget.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final Node node;

  const Header({super.key, required this.node});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(title: UnilingualTextWidget(multilingualText: node.value as MultilingualText));
  }
}
