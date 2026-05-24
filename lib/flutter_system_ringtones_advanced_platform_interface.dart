import 'package:flutter_system_ringtones_advanced/src/ringtone.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_system_ringtones_advanced_method_channel.dart';

abstract class FlutterSystemRingtonesPlatform extends PlatformInterface {
  FlutterSystemRingtonesPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterSystemRingtonesPlatform _instance =
      MethodChannelFlutterSystemRingtones();

  static FlutterSystemRingtonesPlatform get instance => _instance;

  static set instance(FlutterSystemRingtonesPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<List<Ringtone>?> getRingtones() {
    throw UnimplementedError('getRingtones() has not been implemented.');
  }

  Future<List<Ringtone>?> getAlarms() {
    throw UnimplementedError('getAlarms() has not been implemented.');
  }

  Future<List<Ringtone>?> getNotifications() {
    throw UnimplementedError('getNotifications() has not been implemented.');
  }
}
