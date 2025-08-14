import AudioToolbox
import Flutter
import UIKit

/// Service class for handling main channel operations
/// Includes device info, battery level, native dialog, and vibration
class MainChannelService {

    func handleMethodCall(
        call: FlutterMethodCall, result: @escaping FlutterResult, activity: AppDelegate
    ) {
        switch call.method {
        case "getDeviceInfo":
            let deviceInfo = getDeviceInfo()
            result(deviceInfo)
        case "getBatteryLevel":
            let batteryLevel = getBatteryLevel()
            result(batteryLevel)
        case "showNativeDialog":
            let args = call.arguments as? [String: Any]
            let title = args?["title"] as? String ?? "Flutter Demo"
            let message = args?["message"] as? String ?? "This is a native dialog!"
            showNativeDialog(activity: activity, title: title, message: message) { response in
                result(response)
            }
        case "vibrate":
            let args = call.arguments as? [String: Any]
            let duration = args?["duration"] as? Int ?? 500
            let success = vibrate(duration: duration)
            result(success)
        default:
            result(FlutterMethodNotImplemented)
        }
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
        UIDevice.current.isBatteryMonitoringEnabled = true
        return Int(UIDevice.current.batteryLevel * 100)
    }

    private func showNativeDialog(
        activity: AppDelegate,
        title: String,
        message: String,
        completion: @escaping (Bool) -> Void
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

            activity.window?.rootViewController?.present(alert, animated: true)
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
