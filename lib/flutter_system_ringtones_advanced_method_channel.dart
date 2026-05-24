import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_system_ringtones_advanced/src/ringtone.dart';

import 'flutter_system_ringtones_advanced_platform_interface.dart';

class MethodChannelFlutterSystemRingtones extends FlutterSystemRingtonesPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_system_ringtones');

  @override
  Future<List<Ringtone>?> getRingtones() async {
    return _invokeRingtoneList('getRingtones');
  }

  @override
  Future<List<Ringtone>?> getAlarms() async {
    return _invokeRingtoneList('getAlarms');
  }

  @override
  Future<List<Ringtone>?> getNotifications() async {
    return _invokeRingtoneList('getNotifications');
  }

  Future<List<Ringtone>?> _invokeRingtoneList(String method) async {
    final raw = await methodChannel.invokeMethod<dynamic>(method);
    return _parseRingtoneList(raw, method);
  }

  @visibleForTesting
  List<Ringtone>? parseRingtoneList(dynamic raw, [String method = 'unknown']) {
    return _parseRingtoneList(raw, method);
  }

  List<Ringtone>? _parseRingtoneList(dynamic raw, String method) {
    if (raw == null) {
      return null;
    }
    if (raw is! List) {
      throw PlatformException(
        code: 'invalid_response',
        message:
            'Expected a List from native "$method" but received ${raw.runtimeType}. '
            'This plugin only supports Android.',
      );
    }
    if (raw.isEmpty) {
      return const [];
    }
    return raw
        .map((item) {
          if (item is! Map) {
            throw PlatformException(
              code: 'invalid_response',
              message: 'Expected Map entries in "$method" response.',
            );
          }
          return Map<String, dynamic>.from(item);
        })
        .map(Ringtone.fromJson)
        .toList();
  }
}
