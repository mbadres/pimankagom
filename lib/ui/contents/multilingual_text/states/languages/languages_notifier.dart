import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pimankagom/constants/languages.dart';
import 'package:pimankagom/ui/configurations/settings/states/settings_provider.dart';
import 'package:pimankagom/ui/contents/multilingual_text/states/languages/languages_state.dart';

class LanguagesNotifier extends Notifier<LanguagesState> {
  @override
  LanguagesState build() {
    final state = ref.watch(settingsProvider);

    return state.maybeWhen(
      data: (settings) => LanguagesState(
        primaryLanguage: settings.getSetting('primary_language').currentValue,
        selectedLanguages:
            languages
                .where((lang) => settings.getSetting('${lang}_language').currentValue != 'None')
                .toList()
              ..sort((a, b) {
                final orderA = int.parse(settings.getSetting('${a}_language').currentValue);
                final orderB = int.parse(settings.getSetting('${b}_language').currentValue);
                return orderA.compareTo(orderB);
              }),
      ),
      orElse: () => LanguagesState(primaryLanguage: languages.first, selectedLanguages: languages),
    );
  }
}
