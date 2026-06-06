import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pimankagom/ui/contents/multilingual_text/states/languages/languages_notifier.dart';
import 'package:pimankagom/ui/contents/multilingual_text/states/languages/languages_state.dart';

final languagesProvider = NotifierProvider<LanguagesNotifier, LanguagesState>(
  () => LanguagesNotifier(),
);
