import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pimankagom/states/settings/settings_notifier.dart';
import 'package:pimankagom/states/settings/settings_state.dart';

final settingsProvider = AsyncNotifierProvider<SettingsNotifier, SettingsState>(
  () => SettingsNotifier(),
);
