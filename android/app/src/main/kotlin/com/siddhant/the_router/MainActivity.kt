package com.siddhant.the_router

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

@main
@objc class MainActivity: FlutterActivity() {
  private val mainChannelService = MainChannelService()
  private val cameraService = CameraService()
  private val locationService = LocationService()
  private val notificationService = NotificationService()
  private val storageService = StorageService()
  private val networkService = NetworkService()

  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    
    // Main channel for basic operations
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "flutter_main_channel")
      .setMethodCallHandler { call, result ->
        mainChannelService.handleMethodCall(call, result, this)
      }

    // Camera channel
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "flutter_camera_channel")
      .setMethodCallHandler { call, result ->
        cameraService.handleMethodCall(call, result, this)
      }

    // Location channel
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "flutter_location_channel")
      .setMethodCallHandler { call, result ->
        locationService.handleMethodCall(call, result, this)
      }

    // Notification channel
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "flutter_notification_channel")
      .setMethodCallHandler { call, result ->
        notificationService.handleMethodCall(call, result, this)
      }

    // Storage channel
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "flutter_storage_channel")
      .setMethodCallHandler { call, result ->
        storageService.handleMethodCall(call, result, this)
      }

    // Network channel
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "flutter_network_channel")
      .setMethodCallHandler { call, result ->
        networkService.handleMethodCall(call, result, this)
      }
  }
}
