import 'package:pimankagom/models/configurations/setting.dart';

extension SettingList on List<Setting> {
  void setAttribute(String id, String? value) {
    if (value == null) {
      return;
    }

    final index = indexWhere((s) => s.id == id);
    if (index == -1) {
      throw Exception('Setting with id $id does not exist.');
    }

    if (!this[index].availableValues.contains(value)) {
      throw Exception('Value $value is not valid for setting $id.');
    }

    this[index] = this[index].copyWith(value: value);
  }

  List<Setting> copyWith({Map<String, String>? settings}) {
    final newSettings = List<Setting>.from(this);

    for (final entry in (settings ?? {}).entries) {
      newSettings.setAttribute(entry.key, entry.value);
    }
    return newSettings;
  }
}
