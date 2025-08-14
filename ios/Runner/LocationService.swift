import CoreLocation
import Flutter

/// Service class for handling location operations
/// Includes GPS coordinates, permission management, and location services status
class LocationService {

    func handleMethodCall(
        call: FlutterMethodCall, result: @escaping FlutterResult, activity: AppDelegate
    ) {
        switch call.method {
        case "getCurrentLocation":
            let locationResult = getCurrentLocation()
            result(locationResult)
        case "checkLocationPermission":
            let hasPermission = checkLocationPermission()
            result(hasPermission)
        case "requestLocationPermission":
            let granted = requestLocationPermission()
            result(granted)
        case "isLocationEnabled":
            let isEnabled = isLocationEnabled()
            result(isEnabled)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func getCurrentLocation() -> [String: Any] {
        if !isLocationEnabled() {
            return [
                "success": false,
                "error": "Location services are disabled",
            ]
        }

        if !checkLocationPermission() {
            return [
                "success": false,
                "error": "Location permission not granted",
            ]
        }

        // Simulated location - in a real app, you'd use CLLocationManager
        return [
            "success": true,
            "latitude": 37.7749,
            "longitude": -122.4194,
            "accuracy": 10.0,
            "message": "Location obtained successfully",
        ]
    }

    private func checkLocationPermission() -> Bool {
        return CLLocationManager.authorizationStatus() == .authorizedWhenInUse
            || CLLocationManager.authorizationStatus() == .authorizedAlways
    }

    private func requestLocationPermission() -> Bool {
        // In a real app, you'd request permission using locationManager.requestWhenInUseAuthorization
        // For demo purposes, we'll simulate permission granted
        return true
    }

    private func isLocationEnabled() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }
}
