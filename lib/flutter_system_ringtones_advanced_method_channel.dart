import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show MethodChannel;
import 'package:flutter_system_ringtones_advanced/src/ringtone.dart';

import 'flutter_system_ringtones_advanced_platform_interface.dart';

class MethodChannelFlutterSystemRingtones extends FlutterSystemRingtonesPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_system_ringtones');

  @override
  Future<List<Ringtone>?> getRingtones() async {
    final ringtones = await methodChannel.invokeMethod<List>('getRingtones');
    return _parseRingtoneList(ringtones);
  }

  @override
  Future<List<Ringtone>?> getAlarms() async {
    final alarms = await methodChannel.invokeMethod<List>('getAlarms');
    return _parseRingtoneList(alarms);
  }

  @override
  Future<List<Ringtone>?> getNotifications() async {
    final notifications =
        await methodChannel.invokeMethod<List>('getNotifications');
    return _parseRingtoneList(notifications);
  }

  List<Ringtone>? _parseRingtoneList(List<dynamic>? items) {
    if (items == null) {
      return null;
    }
    return items
        .map((item) => Map<String, dynamic>.from(item as Map))
        .map(Ringtone.fromJson)
        .toList();
  }
}
