import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pimankagom/constants/languages.dart';
import 'package:pimankagom/models/configurations/setting.dart';

class DefaultSettingsService {
  List<Setting> getDefaultSettings() {
    return [
      Setting(
        id: 'text_size',
        name: 'Text Size',
        description: 'Adjust the size of the text in the app.',
        category: 'Appearance',
        currentValue: 'medium',
        defaultValue: 'medium',
        availableValues: ['tiny', 'small', 'medium', 'large', 'huge'],
      ),
      Setting(
        id: 'view',
        name: 'View Mode',
        description: 'Adjust the scrolling behavior in the app.',
        category: 'Appearance',
        currentValue: 'scroll',
        defaultValue: 'scroll',
        availableValues: ['scroll', 'slide'],
      ),
      Setting(
        id: 'contrast_mode',
        name: 'Contrast Mode',
        description: 'Enable high contrast mode for better visibility.',
        category: 'Appearance',
        currentValue: 'Off',
        defaultValue: 'Off',
        availableValues: ['On', 'Off'],
      ),
      ...languages.asMap().entries.map(
        (entry) => Setting(
          id: '${entry.value}_language',
          name: '${entry.value} Language',
          description: 'Adjust the display order of ${entry.value} in the app.',
          category: 'Language',
          currentValue: entry.key.toString(),
          defaultValue: entry.key.toString(),
          availableValues:
              ['None'] + Iterable.generate(languages.length, (i) => i.toString()).toList(),
        ),
      ),
      Setting(
        id: 'primary_language',
        name: 'Primary Language',
        description: 'Select the primary language for the app.',
        category: 'Language',
        currentValue: languages.first,
        defaultValue: languages.first,
        availableValues: languages,
      ),
    ];
  }
}

final defaultSettingsServiceProvider = Provider<DefaultSettingsService>(
  (ref) => DefaultSettingsService(),
);
