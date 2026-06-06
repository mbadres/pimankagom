import 'package:flutter/material.dart';
import 'package:pimankagom/data/nodes/libraries.dart';
import 'package:pimankagom/ui/nodes/selector.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber)),
      home: const Selector(node: ID_EE2DD31D_C3AC_4ED1_8730_D9AE3A3E5ED1),
      debugShowCheckedModeBanner: false,
    );
  }
}
