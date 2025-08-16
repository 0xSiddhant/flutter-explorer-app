import Flutter
import Foundation

/// iOS implementation of date change observer
/// Monitors system date changes using NotificationCenter
class DateChangeObserver: NSObject, FlutterStreamHandler {

    private var eventSink: FlutterEventSink?
    private var lastKnownDate: Date = Date()
    private var isObserving = false

    func handleMethodCall(call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "initialize":
            initializeDateObserver()
            result(nil)
        case "dispose":
            disposeDateObserver()
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    // MARK: - FlutterPlugin

    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "initialize":
            initializeDateObserver()
            result(nil)
        case "dispose":
            disposeDateObserver()
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    // MARK: - FlutterStreamHandler

    @objc func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink)
        -> FlutterError?
    {
        eventSink = events
        print("DateChangeObserver: Event listener started")
        return nil
    }

    @objc func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        print("DateChangeObserver: Event listener cancelled")
        return nil
    }

    // MARK: - Private Methods

    private func initializeDateObserver() {
        guard !isObserving else {
            print("DateChangeObserver: Already observing")
            return
        }

        do {
            // Store current date as reference
            lastKnownDate = Date()

            // Start observing date changes
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(handleDateChange),
                name: .NSCalendarDayChanged,
                object: nil
            )

            // Also observe time zone changes
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(handleDateChange),
                name: .NSSystemTimeZoneDidChange,
                object: nil
            )

            isObserving = true
            print("DateChangeObserver: Initialized successfully")
        } catch {
            print("DateChangeObserver: Failed to initialize - \(error)")
        }
    }

    @objc private func handleDateChange() {
        let currentDate = Date()

        // Check if date actually changed (not just time)
        if isDateChanged(currentDate) {
            print("DateChangeObserver: Date change detected - \(currentDate)")

            // Send event to Flutter
            let eventData: [String: Any] = [
                "timestamp": Int(currentDate.timeIntervalSince1970 * 1000),
                "date": currentDate.description,
            ]

            eventSink?(eventData)
            lastKnownDate = currentDate
        }
    }

    private func isDateChanged(_ currentDate: Date) -> Bool {
        let calendar = Calendar.current

        let lastComponents = calendar.dateComponents([.year, .month, .day], from: lastKnownDate)
        let currentComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)

        return lastComponents.year != currentComponents.year
            || lastComponents.month != currentComponents.month
            || lastComponents.day != currentComponents.day
    }

    private func disposeDateObserver() {
        guard isObserving else {
            print("DateChangeObserver: Not observing")
            return
        }

        // Remove observers
        NotificationCenter.default.removeObserver(self, name: .NSCalendarDayChanged, object: nil)
        NotificationCenter.default.removeObserver(
            self, name: .NSSystemTimeZoneDidChange, object: nil)

        // Clear event sink
        eventSink = nil
        isObserving = false

        print("DateChangeObserver: Disposed successfully")
    }

    deinit {
        disposeDateObserver()
    }
}
