/// Lists system ringtones, alarms, and notification sounds on Android.
///
/// Import this library to use [FlutterSystemRingtones] and [Ringtone].
///
/// ```dart
/// import 'package:flutter_system_ringtones_advanced/flutter_system_ringtones_advanced.dart';
///
/// if (FlutterSystemRingtones.isSupported) {
///   final sounds = await FlutterSystemRingtones.getRingtoneSounds();
/// }
/// ```
library;

import 'package:flutter/foundation.dart';
import 'package:flutter_system_ringtones_advanced/src/ringtone.dart';

import 'flutter_system_ringtones_advanced_platform_interface.dart';

export 'src/ringtone.dart';

/// Entry point for reading Android system ringtone, alarm, and notification sounds.
///
/// On non-Android platforms [isSupported] is `false` and list methods return
/// an empty list without calling native code.
class FlutterSystemRingtones {
  FlutterSystemRingtones._();

  /// Whether this device supports listing system sounds (`true` on Android only).
  static bool get isSupported => defaultTargetPlatform == TargetPlatform.android;

  /// Returns the device's available **ringtone** sounds.
  ///
  /// Each [Ringtone.uri] is an Android `content://` URI suitable for playback
  /// via a media player (see package README). Returns an empty list when
  /// [isSupported] is `false` or when no tones are available.
  static Future<List<Ringtone>> getRingtoneSounds() async {
    if (!isSupported) {
      return const [];
    }
    return await FlutterSystemRingtonesPlatform.instance.getRingtones() ?? [];
  }

  /// Returns the device's available **alarm** sounds.
  ///
  /// See [getRingtoneSounds] for platform behavior and URI details.
  static Future<List<Ringtone>> getAlarmSounds() async {
    if (!isSupported) {
      return const [];
    }
    return await FlutterSystemRingtonesPlatform.instance.getAlarms() ?? [];
  }

  /// Returns the device's available **notification** sounds.
  ///
  /// See [getRingtoneSounds] for platform behavior and URI details.
  static Future<List<Ringtone>> getNotificationSounds() async {
    if (!isSupported) {
      return const [];
    }
    return await FlutterSystemRingtonesPlatform.instance.getNotifications() ?? [];
  }
}
