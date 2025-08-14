package com.siddhant.the_router

import android.app.AlertDialog
import android.content.Context
import android.os.Build
import android.os.VibrationEffect
import android.os.Vibrator
import android.os.VibratorManager
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * Service class for handling main channel operations
 * Includes device info, battery level, native dialog, and vibration
 */
class MainChannelService {
  
  fun handleMethodCall(call: MethodCall, result: MethodChannel.Result, activity: MainActivity) {
    when (call.method) {
      "getDeviceInfo" -> {
        val deviceInfo = getDeviceInfo()
        result.success(deviceInfo)
      }
      "getBatteryLevel" -> {
        val batteryLevel = getBatteryLevel()
        result.success(batteryLevel)
      }
      "showNativeDialog" -> {
        val title = call.argument<String>("title") ?: "Flutter Demo"
        val message = call.argument<String>("message") ?: "This is a native dialog!"
        showNativeDialog(activity, title, message) { response ->
          result.success(response)
        }
      }
      "vibrate" -> {
        val duration = call.argument<Int>("duration") ?: 500
        val success = vibrate(activity, duration)
        result.success(success)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  private fun getDeviceInfo(): Map<String, String> {
    return mapOf(
      "platform" to "Android",
      "version" to Build.VERSION.RELEASE,
      "device" to "${Build.MANUFACTURER} ${Build.MODEL}",
      "sdkLevel" to Build.VERSION.SDK_INT.toString(),
      "hardware" to Build.HARDWARE,
      "product" to Build.PRODUCT
    )
  }

  private fun getBatteryLevel(): Int {
    // This is a simplified implementation
    // In a real app, you'd use BatteryManager to get actual battery level
    return (Math.random() * 100).toInt()
  }

  private fun showNativeDialog(
    activity: MainActivity,
    title: String,
    message: String,
    callback: (Boolean) -> Unit
  ) {
    activity.runOnUiThread {
      AlertDialog.Builder(activity)
        .setTitle(title)
        .setMessage(message)
        .setPositiveButton("OK") { _, _ ->
          callback(true)
        }
        .setNegativeButton("Cancel") { _, _ ->
          callback(false)
        }
        .setOnCancelListener {
          callback(false)
        }
        .show()
    }
  }

  private fun vibrate(activity: MainActivity, duration: Int): Boolean {
    return try {
      val vibrator = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
        val vibratorManager = activity.getSystemService(Context.VIBRATOR_MANAGER_SERVICE) as VibratorManager
        vibratorManager.defaultVibrator
      } else {
        @Suppress("DEPRECATION")
        activity.getSystemService(Context.VIBRATOR_SERVICE) as Vibrator
      }

      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
        vibrator.vibrate(VibrationEffect.createOneShot(duration.toLong(), VibrationEffect.DEFAULT_AMPLITUDE))
      } else {
        @Suppress("DEPRECATION")
        vibrator.vibrate(duration.toLong())
      }
      true
    } catch (e: Exception) {
      false
    }
  }
}
