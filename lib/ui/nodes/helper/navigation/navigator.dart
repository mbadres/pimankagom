import 'package:flutter/material.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/ui/configurations/settings/widgets/settings.dart';

class Navigatorr extends StatelessWidget {
  final Node node;

  const Navigatorr({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Settings(),
    );
  }
}
