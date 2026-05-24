import 'package:flutter_system_ringtones_advanced/src/ringtone.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_system_ringtones_advanced_method_channel.dart';

/// Platform contract for loading system sounds from the host OS.
///
/// Apps normally use [FlutterSystemRingtones] instead of calling this directly.
abstract class FlutterSystemRingtonesPlatform extends PlatformInterface {
  /// Creates a platform interface instance for subclassing in tests or mocks.
  FlutterSystemRingtonesPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterSystemRingtonesPlatform _instance =
      MethodChannelFlutterSystemRingtones();

  /// The singleton platform implementation used by the plugin.
  static FlutterSystemRingtonesPlatform get instance => _instance;

  /// Replaces the platform implementation (for example in tests).
  static set instance(FlutterSystemRingtonesPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Loads ringtone-type system sounds, or `null` if the platform returns nothing.
  Future<List<Ringtone>?> getRingtones() {
    throw UnimplementedError('getRingtones() has not been implemented.');
  }

  /// Loads alarm-type system sounds, or `null` if the platform returns nothing.
  Future<List<Ringtone>?> getAlarms() {
    throw UnimplementedError('getAlarms() has not been implemented.');
  }

  /// Loads notification-type system sounds, or `null` if the platform returns nothing.
  Future<List<Ringtone>?> getNotifications() {
    throw UnimplementedError('getNotifications() has not been implemented.');
  }
}
