import Flutter

/// Service class for handling storage operations
/// Includes saving, loading, deleting data and storage information
class StorageService {

    func handleMethodCall(
        call: FlutterMethodCall, result: @escaping FlutterResult, activity: AppDelegate
    ) {
        switch call.method {
        case "saveData":
            let args = call.arguments as? [String: Any]
            let key = args?["key"] as? String ?? ""
            let value = args?["value"] as? String ?? ""
            let success = saveData(key: key, value: value)
            result(success)
        case "loadData":
            let args = call.arguments as? [String: Any]
            let key = args?["key"] as? String ?? ""
            let data = loadData(key: key)
            result(data)
        case "deleteData":
            let args = call.arguments as? [String: Any]
            let key = args?["key"] as? String ?? ""
            let success = deleteData(key: key)
            result(success)
        case "clearAllData":
            let success = clearAllData()
            result(success)
        case "getStorageInfo":
            let storageInfo = getStorageInfo()
            result(storageInfo)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func saveData(key: String, value: String) -> Bool {
        let userDefaults = UserDefaults.standard
        userDefaults.set(value, forKey: key)
        return userDefaults.synchronize()
    }

    private func loadData(key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }

    private func deleteData(key: String) -> Bool {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: key)
        return userDefaults.synchronize()
    }

    private func clearAllData() -> Bool {
        let userDefaults = UserDefaults.standard
        let domain = Bundle.main.bundleIdentifier!
        userDefaults.removePersistentDomain(forName: domain)
        return userDefaults.synchronize()
    }

    private func getStorageInfo() -> [String: Any] {
        let userDefaults = UserDefaults.standard
        let dictionary = userDefaults.dictionaryRepresentation()
        let dataSize = dictionary.count

        return [
            "success": true,
            "dataSize": dataSize,
            "totalKeys": dictionary.keys.count,
            "storageType": "UserDefaults",
        ]
    }
}
