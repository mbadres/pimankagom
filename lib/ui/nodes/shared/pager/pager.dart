import 'package:flutter/material.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/ui/nodes/shared/pager/pager_state.dart';

class Pager extends StatefulWidget {
  final Node node;

  const Pager({super.key, required this.node});

  @override
  State<Pager> createState() => PagerState();
}
