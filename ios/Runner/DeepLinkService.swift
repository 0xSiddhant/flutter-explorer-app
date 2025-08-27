import Flutter
import Foundation

/// Service for handling deep link method channel communication
/// Manages deep link detection, parsing, and communication with Flutter
class DeepLinkService: NSObject {
    private var methodChannel: FlutterMethodChannel?
    private var initialDeepLink: String?

    /**
     * Set the method channel for communication with Flutter
     */
    func setMethodChannel(_ channel: FlutterMethodChannel) {
        self.methodChannel = channel
    }

    /**
     * Handle deep link from URL
     * Called when app receives a deep link URL
     */
    func handleDeepLink(url: URL) {
        print("DeepLinkService: Received URL: \(url.absoluteString)")
        print("DeepLinkService: URL scheme: \(url.scheme ?? "nil")")

        if url.scheme == "frouter" {
            let deepLinkUrl = url.absoluteString
            print("DeepLinkService: Processing frouter deep link: \(deepLinkUrl)")

            // Store initial deep link if not already set
            if initialDeepLink == nil {
                initialDeepLink = deepLinkUrl
                print("DeepLinkService: Stored initial deep link: \(deepLinkUrl)")
            }

            // Send deep link to Flutter
            print("DeepLinkService: Sending deep link to Flutter: \(deepLinkUrl)")
            methodChannel?.invokeMethod("handleDeepLink", arguments: deepLinkUrl)
        } else {
            print("DeepLinkService: URL scheme is not frouter, ignoring")
        }
    }

    /**
     * Check if the given URL is a deep link
     */
    func isDeepLink(url: URL) -> Bool {
        return url.scheme == "frouter"
    }

    /**
     * Get the deep link URL from URL object
     */
    func getDeepLinkUrl(from url: URL) -> String? {
        if isDeepLink(url: url) {
            return url.absoluteString
        }
        return nil
    }

    /**
     * Clear the initial deep link
     * Useful for testing or when you want to reset the initial link
     */
    func clearInitialDeepLink() {
        initialDeepLink = nil
    }

    /**
     * Get the current initial deep link
     */
    func getInitialDeepLink() -> String? {
        return initialDeepLink
    }

    /**
     * Dispose resources
     */
    func dispose() {
        methodChannel?.setMethodCallHandler(nil)
        methodChannel = nil
        initialDeepLink = nil
    }
}
