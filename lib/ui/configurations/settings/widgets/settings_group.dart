import 'package:flutter/material.dart';
import 'package:pimankagom/models/configurations/setting.dart' as model;
import 'package:pimankagom/ui/configurations/settings/widgets/setting.dart';

class SettingsGroup extends StatelessWidget {
  final String category;

  final List<model.Setting> settings;

  const SettingsGroup({super.key, required this.category, required this.settings});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(category, style: Theme.of(context).textTheme.titleLarge),
        ...settings.map((setting) => Setting(setting: setting)),
      ],
    );
  }
}
