import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pimankagom/states/content/outline_provider.dart';
import 'package:pimankagom/states/settings/settings_provider.dart';
import 'package:pimankagom/themes/contrast/contrast_theme.dart';
import 'package:pimankagom/themes/palimpsest/palimpsest_theme.dart';
import 'package:pimankagom/ui/nodes/selector.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final outline = ref.watch(outlineProvider);
    final systemHighContrast = MediaQuery.of(context).highContrast;

    final nightMode = settings.maybeWhen(
      data: (s) => s.getSetting('night_mode').currentValue,
      orElse: () => 'auto',
    );

    final contrastMode = settings.maybeWhen(
      data: (s) => s.getSetting('contrast_mode').currentValue,
      orElse: () => 'auto',
    );

    final themeMode = switch (nightMode) {
      'on' => ThemeMode.dark,
      'off' => ThemeMode.light,
      _ => ThemeMode.system,
    };

    final useContrastTheme = switch (contrastMode) {
      'on' => true,
      'off' => false,
      _ => systemHighContrast,
    };

    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: themeMode,
      theme: useContrastTheme ? contrastLightTheme : palimpsestLightTheme,
      darkTheme: useContrastTheme ? contrastDarkTheme : palimpsestDarkTheme,
      home: outline.when(
        data: (library) => Selector(node: library),
        loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (error, stackTrace) => Scaffold(body: Center(child: Text('$error'))),
      ),
      // debugShowCheckedModeBanner: false,
    );
  }
}
