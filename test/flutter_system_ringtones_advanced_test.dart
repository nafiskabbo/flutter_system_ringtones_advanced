import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_system_ringtones_advanced/flutter_system_ringtones_advanced.dart';
import 'package:flutter_system_ringtones_advanced/flutter_system_ringtones_advanced_platform_interface.dart';
import 'package:flutter_system_ringtones_advanced/src/ringtone.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class _FakePlatform extends FlutterSystemRingtonesPlatform
    with MockPlatformInterfaceMixin {
  @override
  Future<List<Ringtone>?> getRingtones() async => const [
        Ringtone(
          id: '1',
          title: 'Bell',
          uri: 'content://media/internal/audio/media/1',
        ),
      ];

  @override
  Future<List<Ringtone>?> getAlarms() async => const [];

  @override
  Future<List<Ringtone>?> getNotifications() async => const [];
}

void main() {
  test('Ringtone fromJson and toJson round-trip', () {
    const ringtone = Ringtone(
      id: '42',
      title: 'Pixie Dust',
      uri: 'content://media/internal/audio/media/42',
    );
    final restored = Ringtone.fromJson(ringtone.toJson());
    expect(restored, ringtone);
  });

  test('Ringtone encoded json round-trip', () {
    const ringtone = Ringtone(
      id: '7',
      title: 'Chime',
      uri: 'content://media/internal/audio/media/7',
    );
    final restored = Ringtone.fromEncodedJson(ringtone.toEncodedJson());
    expect(restored, ringtone);
  });

  test('platform instance returns lists from fake platform', () async {
    FlutterSystemRingtonesPlatform.instance = _FakePlatform();
    final ringtones =
        await FlutterSystemRingtonesPlatform.instance.getRingtones();
    expect(ringtones, hasLength(1));
    expect(ringtones!.first.title, 'Bell');
  });
}
