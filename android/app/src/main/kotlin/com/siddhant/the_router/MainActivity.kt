package com.siddhant.the_router

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import android.os.Build
import android.os.VibrationEffect
import android.os.Vibrator
import android.os.VibratorManager
import android.app.AlertDialog
import android.content.DialogInterface

class MainActivity: FlutterActivity() {
    private val CHANNEL = "flutter_demo_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getDeviceInfo" -> {
                    val deviceInfo = getDeviceInfo()
                    result.success(deviceInfo)
                }
                "getBatteryLevel" -> {
                    // Note: This is a simplified implementation
                    // In a real app, you'd use BatteryManager to get actual battery level
                    val batteryLevel = getBatteryLevel()
                    result.success(batteryLevel)
                }
                "showNativeDialog" -> {
                    val title = call.argument<String>("title") ?: "Flutter Demo"
                    val message = call.argument<String>("message") ?: "This is a native dialog!"
                    showNativeDialog(title, message) { response ->
                        result.success(response)
                    }
                }
                "vibrate" -> {
                    val duration = call.argument<Int>("duration") ?: 500
                    val success = vibrate(duration)
                    result.success(success)
                }
                else -> {
                    result.notImplemented()
                }
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

    private fun showNativeDialog(title: String, message: String, callback: (Boolean) -> Unit) {
        runOnUiThread {
            AlertDialog.Builder(this)
                .setTitle(title)
                .setMessage(message)
                .setPositiveButton("OK") { dialog, which ->
                    callback(true)
                }
                .setNegativeButton("Cancel") { dialog, which ->
                    callback(false)
                }
                .setOnCancelListener {
                    callback(false)
                }
                .show()
        }
    }

    private fun vibrate(duration: Int): Boolean {
        return try {
            val vibrator = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                val vibratorManager = getSystemService(Context.VIBRATOR_MANAGER_SERVICE) as VibratorManager
                vibratorManager.defaultVibrator
            } else {
                @Suppress("DEPRECATION")
                getSystemService(Context.VIBRATOR_SERVICE) as Vibrator
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
