import AVFoundation
import Flutter

/// Service class for handling camera operations
/// Includes photo capture and permission management
class CameraService {

    func handleMethodCall(
        call: FlutterMethodCall, result: @escaping FlutterResult, activity: AppDelegate
    ) {
        switch call.method {
        case "takePhoto":
            if checkCameraPermission() {
                let photoResult = takePhoto()
                result(photoResult)
            } else {
                requestCameraPermissionWithCallback(activity: activity) { granted in
                    if granted {
                        let photoResult = self.takePhoto()
                        result(photoResult)
                    } else {
                        result([
                            "success": false,
                            "error": "Camera permission denied"
                        ])
                    }
                }
            }
        case "checkCameraPermission":
            let hasPermission = checkCameraPermission()
            result(hasPermission)
        case "requestCameraPermission":
            requestCameraPermissionWithCallback(activity: activity) { granted in
                result(granted)
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func takePhoto() -> [String: Any] {
        // Simulated photo capture - in a real app, you'd use UIImagePickerController
        return [
            "success": true,
            "path": "/var/mobile/Media/DCIM/simulated_photo.jpg",
            "message": "Photo captured successfully",
        ]
    }

    private func checkCameraPermission() -> Bool {
        return AVCaptureDevice.authorizationStatus(for: .video) == .authorized
    }

    private func requestCameraPermission() -> Bool {
        // In a real app, you'd request permission using AVCaptureDevice.requestAccess
        // For demo purposes, we'll simulate permission granted
        return true
    }

    private func requestCameraPermissionWithCallback(activity: AppDelegate, completion: @escaping (Bool) -> Void) {
        if checkCameraPermission() {
            completion(true)
            return
        }
        
        // In a real app, you'd use AVCaptureDevice.requestAccess
        // For demo purposes, we'll simulate the permission request
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Camera Permission", message: "This app needs camera permission to take photos. Please grant permission in Settings.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Grant", style: .default) { _ in
                completion(true)
            })
            
            alert.addAction(UIAlertAction(title: "Deny", style: .cancel) { _ in
                completion(false)
            })
            
            activity.window?.rootViewController?.present(alert, animated: true)
        }
    }
}
