package com.siddhant.the_router

import android.content.Intent
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/**
 * Service for handling deep link method channel communication
 * Manages deep link detection, parsing, and communication with Flutter
 */
class DeepLinkService : MethodCallHandler {
  private var methodChannel: MethodChannel? = null
  private var initialDeepLink: String? = null

  /**
   * Initialize the deep link service with the method channel
   */
  fun initialize(methodChannel: MethodChannel) {
    this.methodChannel = methodChannel
    methodChannel.setMethodCallHandler(this)
  }

  /**
   * Handle method calls from Flutter
   */
  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "getInitialLink" -> {
        result.success(initialDeepLink)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  /**
   * Handle deep link from intent
   * Called when app receives a deep link intent
   */
  fun handleDeepLink(intent: Intent) {
    val data = intent.data
    if (data != null && data.scheme == "frouter") {
      val deepLinkUrl = data.toString()
      
      // Store initial deep link if not already set
      if (initialDeepLink == null) {
        initialDeepLink = deepLinkUrl
      }
      
      // Send deep link to Flutter
      methodChannel?.invokeMethod("handleDeepLink", deepLinkUrl)
    }
  }

  /**
   * Check if the given intent contains a deep link
   */
  fun hasDeepLink(intent: Intent): Boolean {
    val data = intent.data
    return data != null && data.scheme == "frouter"
  }

  /**
   * Get the deep link URL from intent
   */
  fun getDeepLinkUrl(intent: Intent): String? {
    val data = intent.data
    return if (data != null && data.scheme == "frouter") {
      data.toString()
    } else {
      null
    }
  }

  /**
   * Clear the initial deep link
   * Useful for testing or when you want to reset the initial link
   */
  fun clearInitialDeepLink() {
    initialDeepLink = null
  }

  /**
   * Get the current initial deep link
   */
  fun getInitialDeepLink(): String? {
    return initialDeepLink
  }

  /**
   * Dispose resources
   */
  fun dispose() {
    methodChannel?.setMethodCallHandler(null)
    methodChannel = null
    initialDeepLink = null
  }
}
