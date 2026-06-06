import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pimankagom/models/configurations/setting.dart';
import 'package:pimankagom/services/default_settings_service.dart';
import 'package:pimankagom/services/local_storage_service.dart';

class SettingsRepository {
  final DefaultSettingsService _defaultSettingsService;
  final FlutterSecureStorage _localStorageService;

  SettingsRepository({
    required DefaultSettingsService defaultSettingsService,
    required FlutterSecureStorage localStorageService,
  }) : _defaultSettingsService = defaultSettingsService,
       _localStorageService = localStorageService;

  void _writeBackDefaultValue(Setting setting) {
    setSetting(setting.id, setting.defaultValue);
  }

  bool _isOutdated(String storedValue, Setting setting) {
    return !setting.availableValues.contains(storedValue);
  }

  Future<List<Setting>> getSettings() async {
    final storedSettings = await _localStorageService.readAll();
    final defaultSettings = _defaultSettingsService.getDefaultSettings();

    return defaultSettings.map((setting) {
      final storedValue = storedSettings[setting.id];

      if (storedValue == null) {
        return setting.copyWith(value: setting.defaultValue);
      }

      if (_isOutdated(storedValue, setting)) {
        _writeBackDefaultValue(setting);
        return setting.copyWith(value: setting.defaultValue);
      }

      return setting.copyWith(value: storedValue);
    }).toList();
  }

  Future<void> setSetting(String id, String value) async {
    final defaultSettings = _defaultSettingsService.getDefaultSettings();
    final settingIndex = defaultSettings.indexWhere((setting) => setting.id == id);
    if (settingIndex != -1) {
      await _localStorageService.write(key: id, value: value);
    }
  }
}

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final defaultSettingsService = ref.watch(defaultSettingsServiceProvider);
  final localStorageService = ref.watch(localStorageServiceProvider);

  return SettingsRepository(
    defaultSettingsService: defaultSettingsService,
    localStorageService: localStorageService,
  );
});
