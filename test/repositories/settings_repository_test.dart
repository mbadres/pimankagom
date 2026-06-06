import 'package:pimankagom/models/configurations/setting.dart';
import 'package:pimankagom/repositories/settings_repository.dart';
import 'package:pimankagom/services/default_settings_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDefaultSettingsService extends Mock implements DefaultSettingsService {}

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

final _defaultSettings = [
  Setting(
    id: 'theme',
    name: 'Theme',
    description: 'The theme of the app.',
    category: 'Appearance',
    currentValue: 'Light',
    defaultValue: 'Light',
    availableValues: ['Light', 'Dark'],
  ),
];

void main() {
  late MockDefaultSettingsService mockDefaultSettingsService;
  late MockFlutterSecureStorage mockFlutterSecureStorage;
  late SettingsRepository settingsRepository;

  setUp(() {
    mockDefaultSettingsService = MockDefaultSettingsService();
    mockFlutterSecureStorage = MockFlutterSecureStorage();
    settingsRepository = SettingsRepository(
      defaultSettingsService: mockDefaultSettingsService,
      localStorageService: mockFlutterSecureStorage,
    );

    when(() => mockDefaultSettingsService.getDefaultSettings()).thenReturn(_defaultSettings);
  });

  group('getSettings', () {
    test('returns defaultValue when no stored value exists', () async {
      when(() => mockFlutterSecureStorage.readAll()).thenAnswer((_) async => {});

      final settings = await settingsRepository.getSettings();

      expect(settings.length, 1);
      expect(settings.first.currentValue, 'Light');
    });

    test('returns stored value when it is valid', () async {
      when(() => mockFlutterSecureStorage.readAll()).thenAnswer((_) async => {'theme': 'Dark'});

      final settings = await settingsRepository.getSettings();

      expect(settings.first.currentValue, 'Dark');
    });

    test('falls back to defaultValue and writes it back when stored value is outdated', () async {
      when(() => mockFlutterSecureStorage.readAll()).thenAnswer((_) async => {'theme': 'Pink'});
      when(
        () => mockFlutterSecureStorage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {});

      final settings = await settingsRepository.getSettings();

      expect(settings.first.currentValue, 'Light');
      verify(() => mockFlutterSecureStorage.write(key: 'theme', value: 'Light')).called(1);
    });
  });

  group('setSetting', () {
    test('writes to storage when id exists in default settings', () async {
      when(
        () => mockFlutterSecureStorage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {});

      await settingsRepository.setSetting('theme', 'Dark');

      verify(() => mockFlutterSecureStorage.write(key: 'theme', value: 'Dark')).called(1);
    });

    test('does not write to storage when id does not exist', () async {
      await settingsRepository.setSetting('unknown_id', 'value');

      verifyNever(
        () => mockFlutterSecureStorage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      );
    });
  });
}
