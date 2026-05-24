import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_system_ringtones_advanced/flutter_system_ringtones_advanced.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('getRingtoneSounds completes on all platforms', (
    WidgetTester tester,
  ) async {
    final ringtones = await FlutterSystemRingtones.getRingtoneSounds();
    expect(ringtones, isA<List<Ringtone>>());
    if (defaultTargetPlatform == TargetPlatform.android) {
      // Device-dependent; only assert type on Android.
      expect(ringtones, isNotNull);
    } else {
      expect(ringtones, isEmpty);
    }
  });
}
