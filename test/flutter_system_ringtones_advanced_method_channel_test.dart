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
}
