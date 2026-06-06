import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pimankagom/repositories/settings_repository.dart';
import 'package:pimankagom/ui/configurations/settings/states/settings_state.dart';

class SettingsNotifier extends AsyncNotifier<SettingsState> {
  bool _isValidValue(String? value, SettingsState data, String id) {
    return value != null && _getAvailableValues(data, id).contains(value);
  }

  String _getDefaultValue(SettingsState data, String id) {
    return data.settings.firstWhere((setting) => setting.id == id).defaultValue;
  }

  List<String> _getAvailableValues(SettingsState data, String id) {
    return data.settings.firstWhere((setting) => setting.id == id).availableValues;
  }

  void _set(SettingsState data, String id, String value) {
    state = AsyncData(data.copyWith(settings: {id: value}));
  }

  void _persist(String id, String value) {
    final settingsRepository = ref.watch(settingsRepositoryProvider);
    settingsRepository.setSetting(id, value);
  }

  void _setAndPersistSettings(SettingsState data, String id, String value) {
    _set(data, id, value);
    _persist(id, value);
  }

  void setSetting(String id, String? value) {
    state.whenData((data) {
      if (_isValidValue(value, data, id)) {
        _setAndPersistSettings(data, id, value!);
      }
    });
  }

  void resetSetting(String id) {
    state.whenData((data) => _setAndPersistSettings(data, id, _getDefaultValue(data, id)));
  }

  @override
  Future<SettingsState> build() async {
    final settingsRepository = ref.watch(settingsRepositoryProvider);
    final settings = await settingsRepository.getSettings();

    return SettingsState(settings: settings);
  }
}
