import 'package:pimankagom/constants/languages.dart';

class LanguagesState {
  final String primaryLanguage;
  final List<String> selectedLanguages;
  final List<String> availableLanguages = languages;

  const LanguagesState({required this.primaryLanguage, required this.selectedLanguages});
}
