import 'package:pimankagom/models/configurations/setting.dart';
import 'package:pimankagom/models/configurations/setting_list.dart';

class SettingsState {
  final List<Setting> settings;

  SettingsState({required this.settings});

  Setting getSetting(String id) {
    return settings.firstWhere((setting) => setting.id == id);
  }

  SettingsState copyWith({Map<String, String>? settings}) {
    return SettingsState(settings: this.settings.copyWith(settings: settings));
  }
}
