import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  private let mainChannelService = MainChannelService()
  private let cameraService = CameraService()
  private let locationService = LocationService()
  private let notificationService = NotificationService()
  private let storageService = StorageService()
  private let networkService = NetworkService()
  private let dateChangeObserver = DateChangeObserver()
  private let deepLinkService = DeepLinkService()

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController

    // Main channel for basic operations
    let mainChannel = FlutterMethodChannel(
      name: "flutter_main_channel",
      binaryMessenger: controller.binaryMessenger)
    mainChannel.setMethodCallHandler { call, result in
      self.mainChannelService.handleMethodCall(call: call, result: result, activity: self)
    }

    // Camera channel
    let cameraChannel = FlutterMethodChannel(
      name: "flutter_camera_channel",
      binaryMessenger: controller.binaryMessenger)
    cameraChannel.setMethodCallHandler { call, result in
      self.cameraService.handleMethodCall(call: call, result: result, activity: self)
    }

    // Location channel
    let locationChannel = FlutterMethodChannel(
      name: "flutter_location_channel",
      binaryMessenger: controller.binaryMessenger)
    locationChannel.setMethodCallHandler { call, result in
      self.locationService.handleMethodCall(call: call, result: result, activity: self)
    }

    // Notification channel
    let notificationChannel = FlutterMethodChannel(
      name: "flutter_notification_channel",
      binaryMessenger: controller.binaryMessenger)
    notificationChannel.setMethodCallHandler { call, result in
      self.notificationService.handleMethodCall(call: call, result: result, activity: self)
    }

    // Storage channel
    let storageChannel = FlutterMethodChannel(
      name: "flutter_storage_channel",
      binaryMessenger: controller.binaryMessenger)
    storageChannel.setMethodCallHandler { call, result in
      self.storageService.handleMethodCall(call: call, result: result, activity: self)
    }

    // Network channel
    let networkChannel = FlutterMethodChannel(
      name: "flutter_network_channel",
      binaryMessenger: controller.binaryMessenger)
    networkChannel.setMethodCallHandler { call, result in
      self.networkService.handleMethodCall(call: call, result: result, activity: self)
    }

    // Date change observer channel
    let dateChangeMethodChannel = FlutterMethodChannel(
      name: "date_change_observer",
      binaryMessenger: controller.binaryMessenger)
    dateChangeMethodChannel.setMethodCallHandler { call, result in
      self.dateChangeObserver.handleMethodCall(call: call, result: result)
    }

    // Date change event channel
    let dateChangeEventChannel = FlutterEventChannel(
      name: "date_change_events",
      binaryMessenger: controller.binaryMessenger)
    dateChangeEventChannel.setStreamHandler(self.dateChangeObserver)

    // Deep link channel
    let deepLinkChannel = FlutterMethodChannel(
      name: "deep_link_channel",
      binaryMessenger: controller.binaryMessenger)
    deepLinkChannel.setMethodCallHandler { call, result in
      switch call.method {
      case "getInitialLink":
        result(self.deepLinkService.getInitialDeepLink())
      default:
        result(FlutterMethodNotImplemented)
      }
    }
    self.deepLinkService.setMethodChannel(deepLinkChannel)

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // Handle deep links when app is opened via URL
  override func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey: Any] = [:]
  ) -> Bool {
    deepLinkService.handleDeepLink(url: url)
    return true
  }

  // Handle deep links when app is already running
  override func application(
    _ application: UIApplication,
    continue userActivity: NSUserActivity,
    restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
  ) -> Bool {
    if userActivity.activityType == NSUserActivityTypeBrowsingWeb,
      let url = userActivity.webpageURL
    {
      deepLinkService.handleDeepLink(url: url)
    }
    return true
  }
}
