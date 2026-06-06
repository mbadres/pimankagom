import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pimankagom/ui/contents/multilingual_text/states/text_size/text_size_notifier.dart';
import 'package:pimankagom/ui/contents/multilingual_text/states/text_size/text_size_state.dart';

final textSizeProvider = NotifierProvider<TextSizeNotifier, TextSizeState>(
  () => TextSizeNotifier(),
);
