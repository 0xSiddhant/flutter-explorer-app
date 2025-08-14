import AudioToolbox
import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(
      name: "flutter_demo_channel",
      binaryMessenger: controller.binaryMessenger)
    channel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      switch call.method {
      case "getDeviceInfo":
        let deviceInfo = self.getDeviceInfo()
        result(deviceInfo)
      case "getBatteryLevel":
        let batteryLevel = self.getBatteryLevel()
        result(batteryLevel)
      case "showNativeDialog":
        let args = call.arguments as? [String: Any]
        let title = args?["title"] as? String ?? "Flutter Demo"
        let message = args?["message"] as? String ?? "This is a native dialog!"
        self.showNativeDialog(title: title, message: message) { response in
          result(response)
        }
      case "vibrate":
        let args = call.arguments as? [String: Any]
        let duration = args?["duration"] as? Int ?? 500
        let success = self.vibrate(duration: duration)
        result(success)
      default:
        result(FlutterMethodNotImplemented)
      }
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func getDeviceInfo() -> [String: String] {
    let device = UIDevice.current
    let systemInfo = UIDevice.current.systemName + " " + UIDevice.current.systemVersion
    let model = UIDevice.current.model
    let name = UIDevice.current.name

    return [
      "platform": "iOS",
      "version": UIDevice.current.systemVersion,
      "device": name,
      "model": model,
      "systemInfo": systemInfo,
    ]
  }

  private func getBatteryLevel() -> Int {
    // This is a simplified implementation
    // In a real app, you'd use UIDevice.batteryLevel to get actual battery level
    return Int.random(in: 0...100)
  }

  private func showNativeDialog(
    title: String, message: String, completion: @escaping (Bool) -> Void
  ) {
    DispatchQueue.main.async {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

      alert.addAction(
        UIAlertAction(title: "OK", style: .default) { _ in
          completion(true)
        })

      alert.addAction(
        UIAlertAction(title: "Cancel", style: .cancel) { _ in
          completion(false)
        })

      self.window?.rootViewController?.present(alert, animated: true)
    }
  }

  private func vibrate(duration: Int) -> Bool {
    // iOS doesn't have a direct vibration API like Android
    // We use AudioToolbox for haptic feedback
    do {
      if #available(iOS 10.0, *) {
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
      } else {
        // Fallback for older iOS versions
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
      }
      return true
    } catch {
      return false
    }
  }
}
