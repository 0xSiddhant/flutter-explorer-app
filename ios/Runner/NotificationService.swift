import Flutter
import UserNotifications

/// Service class for handling notification operations
/// Includes creating, canceling notifications and permission management
class NotificationService {

    func handleMethodCall(
        call: FlutterMethodCall, result: @escaping FlutterResult, activity: AppDelegate
    ) {
        switch call.method {
        case "showNotification":
            let args = call.arguments as? [String: Any]
            let title = args?["title"] as? String ?? "Notification"
            let message = args?["message"] as? String ?? "This is a notification"
            let id = args?["id"] as? Int ?? 1
            let success = showNotification(title: title, message: message, id: id)
            result(success)
        case "cancelNotification":
            let args = call.arguments as? [String: Any]
            let id = args?["id"] as? Int ?? 1
            let success = cancelNotification(id: id)
            result(success)
        case "cancelAllNotifications":
            let success = cancelAllNotifications()
            result(success)
        case "checkNotificationPermission":
            let hasPermission = checkNotificationPermission()
            result(hasPermission)
        case "requestNotificationPermission":
            let granted = requestNotificationPermission()
            result(granted)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func showNotification(title: String, message: String, id: Int) -> Bool {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "\(id)", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error showing notification: \(error)")
            }
        }
        return true
    }

    private func cancelNotification(id: Int) -> Bool {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [
            "\(id)"
        ])
        return true
    }

    private func cancelAllNotifications() -> Bool {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        return true
    }

    private func checkNotificationPermission() -> Bool {
        // For demo purposes, we'll simulate permission granted
        // In a real app, you'd check UNUserNotificationCenter.current().getNotificationSettings
        return true
    }

    private func requestNotificationPermission() -> Bool {
        // In a real app, you'd request permission using UNUserNotificationCenter.current().requestAuthorization
        // For demo purposes, we'll simulate permission granted
        return true
    }
}
