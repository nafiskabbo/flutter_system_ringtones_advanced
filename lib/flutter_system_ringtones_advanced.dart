import 'package:flutter_system_ringtones_advanced/src/ringtone.dart';

import 'flutter_system_ringtones_advanced_platform_interface.dart';

export 'src/ringtone.dart';

class FlutterSystemRingtones {
  FlutterSystemRingtones._();

  static Future<List<Ringtone>> getRingtoneSounds() async {
    return await FlutterSystemRingtonesPlatform.instance.getRingtones() ?? [];
  }

  static Future<List<Ringtone>> getAlarmSounds() async {
    return await FlutterSystemRingtonesPlatform.instance.getAlarms() ?? [];
  }

  static Future<List<Ringtone>> getNotificationSounds() async {
    return await FlutterSystemRingtonesPlatform.instance.getNotifications() ?? [];
  }
}
