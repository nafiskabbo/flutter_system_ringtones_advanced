import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_system_ringtones_advanced/flutter_system_ringtones_advanced.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('getRingtoneSounds completes', (WidgetTester tester) async {
    final ringtones = await FlutterSystemRingtones.getRingtoneSounds();
    expect(ringtones, isA<List<Ringtone>>());
  });
}
