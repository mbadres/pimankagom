import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pimankagom/ui/app/app.dart';

void main() {
  testWidgets('app starts without crashing', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(const ProviderScope(child: App()));
      await Future.delayed(const Duration(seconds: 1));
    });
    await tester.pump();
  });
}
