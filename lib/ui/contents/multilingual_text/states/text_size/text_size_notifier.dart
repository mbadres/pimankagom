import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pimankagom/ui/configurations/settings/states/settings_provider.dart';
import 'package:pimankagom/ui/contents/multilingual_text/states/text_size/text_size_state.dart';

class TextSizeNotifier extends Notifier<TextSizeState> {
  @override
  TextSizeState build() {
    final state = ref.watch(settingsProvider);

    return state.maybeWhen(
      data: (s) => TextSizeState(
        scale: switch (s.getSetting('text_size').currentValue) {
          'Tiny' => 0.7,
          'Small' => 0.85,
          'Medium' => 1.0,
          'Large' => 1.2,
          'Huge' => 1.4,
          _ => 1.0,
        },
      ),
      orElse: () => const TextSizeState(scale: 1.0),
    );
  }
}
