import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
   let controller = window?.rootViewController as! FlutterViewController

      let channel = FlutterMethodChannel(
        name: "native/battery",
        binaryMessenger: controller.binaryMessenger
      )

      channel.setMethodCallHandler { (call, result) in
        if call.method == "getBatteryLevel" {
          self.getBatteryLevel(result: result)
        } else {
          result(FlutterMethodNotImplemented)
        }
      }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func getBatteryLevel(result: FlutterResult) {
      UIDevice.current.isBatteryMonitoringEnabled = true
      let level = UIDevice.current.batteryLevel

      if level < 0 {
        result(FlutterError(
          code: "UNAVAILABLE",
          message: "Battery level not available",
          details: nil
        ))
      } else {
        result("\((Int(level * 100)))%")
      }
    }
}
