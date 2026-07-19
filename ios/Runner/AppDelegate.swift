import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {

  private let channel = "battery_channel"

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let batteryChannel = FlutterMethodChannel(
      name: channel,
      binaryMessenger: controller.binaryMessenger
    )

    batteryChannel.setMethodCallHandler { call, result in

        if call.method == "getBatteryLevel" {

            UIDevice.current.isBatteryMonitoringEnabled = true

            let batteryLevel = UIDevice.current.batteryLevel

            if batteryLevel == -1 {
                result(FlutterError(
                    code: "UNAVAILABLE",
                    message: "Battery level unavailable",
                    details: nil
                ))
            } else {
                result(Int(batteryLevel * 100))
            }
        } else {
            result(FlutterMethodNotImplemented)
        }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}
