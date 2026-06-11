import 'package:flutter/material.dart';
import 'package:pimankagom/data/nodes/libraries.dart';
import 'package:pimankagom/themes/contrast_mode_theme.dart';
import 'package:pimankagom/themes/pimankagom_theme.dart';
import 'package:pimankagom/ui/app/app.dart';
import 'package:pimankagom/ui/nodes/selector.dart';

class AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAccessibilityFeatures() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final isHighContrast = MediaQueryData.fromView(View.of(context)).highContrast;

    return MaterialApp(
      title: 'Flutter Demo',
      theme: isHighContrast ? contrastModeLightTheme : pimankagomLightTheme,
      darkTheme: isHighContrast ? contrastModeDarkTheme : pimankagomDarkTheme,
      home: const Selector(node: ID_EE2DD31D_C3AC_4ED1_8730_D9AE3A3E5ED1),
      debugShowCheckedModeBanner: false,
    );
  }
}
