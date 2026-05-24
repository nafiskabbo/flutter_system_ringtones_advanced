import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_system_ringtones_advanced/flutter_system_ringtones_advanced_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final platform = MethodChannelFlutterSystemRingtones();
  const channel = MethodChannel('flutter_system_ringtones');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'getRingtones':
          return [
            {
              'id': '1',
              'title': 'Test',
              'uri': 'content://media/internal/audio/media/1',
            },
          ];
        case 'getAlarms':
          return <dynamic>[];
        default:
          return null;
      }
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getRingtones parses native maps', () async {
    final ringtones = await platform.getRingtones();
    expect(ringtones, hasLength(1));
    expect(ringtones!.first.id, '1');
    expect(ringtones.first.title, 'Test');
    expect(
      ringtones.first.uri,
      'content://media/internal/audio/media/1',
    );
  });

  test('getAlarms returns empty list from native', () async {
    final alarms = await platform.getAlarms();
    expect(alarms, isEmpty);
  });

  test('parseRingtoneList rejects non-list native responses', () {
    expect(
      () => platform.parseRingtoneList('iOS 17.0', 'getNotifications'),
      throwsA(
        isA<PlatformException>().having(
          (e) => e.code,
          'code',
          'invalid_response',
        ),
      ),
    );
  });

  test('parseRingtoneList rejects map entries', () {
    expect(
      () => platform.parseRingtoneList(['not-a-map'], 'getRingtones'),
      throwsA(
        isA<PlatformException>().having(
          (e) => e.code,
          'code',
          'invalid_response',
        ),
      ),
    );
  });
}
