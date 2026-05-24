import Flutter
import UIKit

public class FlutterSystemRingtonesPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "flutter_system_ringtones",
      binaryMessenger: registrar.messenger())
    let instance = FlutterSystemRingtonesPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getRingtones", "getAlarms", "getNotifications":
      // iOS dynamic system sound listing is not implemented yet.
      result([])
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
