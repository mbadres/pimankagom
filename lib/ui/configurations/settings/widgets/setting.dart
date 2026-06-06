import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pimankagom/models/configurations/setting.dart' as model;
import 'package:pimankagom/ui/configurations/settings/states/settings_provider.dart';

class Setting extends ConsumerWidget {
  final model.Setting setting;

  const Setting({super.key, required this.setting});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsNotifier = ref.read(settingsProvider.notifier);
    return Row(
      children: [
        Text(setting.name),
        const Text(' '),
        const Spacer(),
        DropdownButton<String>(
          value: setting.currentValue,
          items: setting.availableValues
              .map((val) => DropdownMenuItem<String>(value: val, child: Text(val)))
              .toList(),
          onChanged: (value) => settingsNotifier.setSetting(setting.id, value),
        ),
        IconButton(
          onPressed: () => settingsNotifier.resetSetting(setting.id),
          icon: const Icon(Icons.restore),
        ),
      ],
    );
  }
}
