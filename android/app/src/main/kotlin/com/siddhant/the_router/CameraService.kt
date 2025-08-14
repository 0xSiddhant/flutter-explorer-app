package com.siddhant.the_router

import android.Manifest
import android.content.pm.PackageManager
import androidx.core.content.ContextCompat
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * Service class for handling camera operations
 * Includes photo capture and permission management
 */
class CameraService {
  
  fun handleMethodCall(call: MethodCall, result: MethodChannel.Result, activity: MainActivity) {
    when (call.method) {
      "takePhoto" -> {
        if (checkCameraPermission(activity)) {
          val photoResult = takePhoto()
          result.success(photoResult)
        } else {
          requestCameraPermissionWithCallback(activity) { granted ->
            if (granted) {
              val photoResult = takePhoto()
              result.success(photoResult)
            } else {
              result.success(mapOf(
                "success" to false,
                "error" to "Camera permission denied"
              ))
            }
          }
        }
      }
      "checkCameraPermission" -> {
        val hasPermission = checkCameraPermission(activity)
        result.success(hasPermission)
      }
      "requestCameraPermission" -> {
        requestCameraPermissionWithCallback(activity) { granted ->
          result.success(granted)
        }
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  private fun takePhoto(): Map<String, Any> {
    return try {
      // Simulated photo capture - in a real app, you'd launch camera intent
      mapOf(
        "success" to true,
        "path" to "/storage/emulated/0/DCIM/simulated_photo.jpg",
        "message" to "Photo captured successfully"
      )
    } catch (e: Exception) {
      mapOf(
        "success" to false,
        "error" to "Failed to take photo: ${e.message}"
      )
    }
  }

  private fun checkCameraPermission(activity: MainActivity): Boolean {
    return ContextCompat.checkSelfPermission(activity, Manifest.permission.CAMERA) == PackageManager.PERMISSION_GRANTED
  }

  private fun requestCameraPermission(): Boolean {
    // In a real app, you'd request permission using ActivityCompat.requestPermissions
    // For demo purposes, we'll simulate permission granted
    return true
  }

  private fun requestCameraPermissionWithCallback(activity: MainActivity, callback: (Boolean) -> Unit) {
    if (checkCameraPermission(activity)) {
      callback(true)
      return
    }
    
    // In a real app, you'd use ActivityCompat.requestPermissions
    // For demo purposes, we'll simulate the permission request
    activity.runOnUiThread {
      val alert = android.app.AlertDialog.Builder(activity)
        .setTitle("Camera Permission")
        .setMessage("This app needs camera permission to take photos. Please grant permission in Settings.")
        .setPositiveButton("Grant") { _, _ ->
          callback(true)
        }
        .setNegativeButton("Deny") { _, _ ->
          callback(false)
        }
        .setCancelable(false)
        .create()
      
      alert.show()
    }
  }
}
