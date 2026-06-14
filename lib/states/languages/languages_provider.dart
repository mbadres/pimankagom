import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pimankagom/states/languages/languages_notifier.dart';
import 'package:pimankagom/states/languages/languages_state.dart';

final languagesProvider = NotifierProvider<LanguagesNotifier, LanguagesState>(
  () => LanguagesNotifier(),
);
