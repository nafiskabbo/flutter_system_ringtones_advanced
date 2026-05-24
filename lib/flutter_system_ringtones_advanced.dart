import 'package:flutter/foundation.dart';
import 'package:flutter_system_ringtones_advanced/src/ringtone.dart';

import 'flutter_system_ringtones_advanced_platform_interface.dart';

export 'src/ringtone.dart';

class FlutterSystemRingtones {
  FlutterSystemRingtones._();

  static bool get isSupported => defaultTargetPlatform == TargetPlatform.android;

  static Future<List<Ringtone>> getRingtoneSounds() async {
    if (!isSupported) {
      return const [];
    }
    return await FlutterSystemRingtonesPlatform.instance.getRingtones() ?? [];
  }

  static Future<List<Ringtone>> getAlarmSounds() async {
    if (!isSupported) {
      return const [];
    }
    return await FlutterSystemRingtonesPlatform.instance.getAlarms() ?? [];
  }

  static Future<List<Ringtone>> getNotificationSounds() async {
    if (!isSupported) {
      return const [];
    }
    return await FlutterSystemRingtonesPlatform.instance.getNotifications() ?? [];
  }
}
