import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pimankagom/ui/configurations/settings/states/settings_notifier.dart';
import 'package:pimankagom/ui/configurations/settings/states/settings_state.dart';

final settingsProvider = AsyncNotifierProvider<SettingsNotifier, SettingsState>(
  () => SettingsNotifier(),
);
