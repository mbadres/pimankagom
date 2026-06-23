import 'package:flutter/material.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/ui/nodes/shared/slides/slides_state.dart';

class Slides extends StatefulWidget {
  final Node node;

  const Slides({super.key, required this.node});

  @override
  State<Slides> createState() => SlidesState();
}
