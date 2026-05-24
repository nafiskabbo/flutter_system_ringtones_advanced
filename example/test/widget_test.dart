import 'package:flutter_system_ringtones_advanced_example/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('app builds', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Plugin example app'), findsOneWidget);
  });
}
