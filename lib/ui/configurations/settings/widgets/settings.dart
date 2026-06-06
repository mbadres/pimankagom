import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pimankagom/ui/configurations/settings/states/settings_provider.dart';
import 'package:pimankagom/ui/configurations/settings/widgets/settings_group.dart';

class Settings extends ConsumerWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(settingsProvider);
    return state.when(
      data: (settingsState) {
        final groupedSettings = groupBy(settingsState.settings, (setting) => setting.category);

        // Prevent a render flex exception in Android by not using a column widget.
        return ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            for (final settingsGroup in groupedSettings.entries)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SettingsGroup(category: settingsGroup.key, settings: settingsGroup.value),
              ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
