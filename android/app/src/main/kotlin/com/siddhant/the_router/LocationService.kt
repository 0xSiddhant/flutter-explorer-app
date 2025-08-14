package com.siddhant.the_router

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.location.LocationManager
import androidx.core.content.ContextCompat
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * Service class for handling location operations
 * Includes GPS coordinates, permission management, and location services status
 */
class LocationService {
  
  fun handleMethodCall(call: MethodCall, result: MethodChannel.Result, activity: MainActivity) {
    when (call.method) {
      "getCurrentLocation" -> {
        if (!isLocationEnabled(activity)) {
          result.success(mapOf(
            "success" to false,
            "error" to "Location services are disabled"
          ))
          return
        }
        
        if (checkLocationPermission(activity)) {
          val locationResult = getCurrentLocation(activity)
          result.success(locationResult)
        } else {
          requestLocationPermissionWithCallback(activity) { granted ->
            if (granted) {
              val locationResult = getCurrentLocation(activity)
              result.success(locationResult)
            } else {
              result.success(mapOf(
                "success" to false,
                "error" to "Location permission denied"
              ))
            }
          }
        }
      }
      "checkLocationPermission" -> {
        val hasPermission = checkLocationPermission(activity)
        result.success(hasPermission)
      }
      "requestLocationPermission" -> {
        requestLocationPermissionWithCallback(activity) { granted ->
          result.success(granted)
        }
      }
      "isLocationEnabled" -> {
        val isEnabled = isLocationEnabled(activity)
        result.success(isEnabled)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  private fun getCurrentLocation(activity: MainActivity): Map<String, Any> {
    return try {
      if (!isLocationEnabled(activity)) {
        return mapOf(
          "success" to false,
          "error" to "Location services are disabled"
        )
      }

      if (!checkLocationPermission(activity)) {
        return mapOf(
          "success" to false,
          "error" to "Location permission not granted"
        )
      }

      // Simulated location - in a real app, you'd use LocationManager
      mapOf(
        "success" to true,
        "latitude" to 37.7749,
        "longitude" to -122.4194,
        "accuracy" to 10.0,
        "message" to "Location obtained successfully"
      )
    } catch (e: Exception) {
      mapOf(
        "success" to false,
        "error" to "Failed to get location: ${e.message}"
      )
    }
  }

  private fun checkLocationPermission(activity: MainActivity): Boolean {
    return ContextCompat.checkSelfPermission(activity, Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED ||
           ContextCompat.checkSelfPermission(activity, Manifest.permission.ACCESS_COARSE_LOCATION) == PackageManager.PERMISSION_GRANTED
  }

  private fun requestLocationPermission(): Boolean {
    // In a real app, you'd request permission using ActivityCompat.requestPermissions
    // For demo purposes, we'll simulate permission granted
    return true
  }

  private fun isLocationEnabled(activity: MainActivity): Boolean {
    val locationManager = activity.getSystemService(Context.LOCATION_SERVICE) as LocationManager
    return locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER) ||
           locationManager.isProviderEnabled(LocationManager.NETWORK_PROVIDER)
  }

  private fun requestLocationPermissionWithCallback(activity: MainActivity, callback: (Boolean) -> Unit) {
    if (checkLocationPermission(activity)) {
      callback(true)
      return
    }
    
    // In a real app, you'd use ActivityCompat.requestPermissions
    // For demo purposes, we'll simulate the permission request
    activity.runOnUiThread {
      val alert = android.app.AlertDialog.Builder(activity)
        .setTitle("Location Permission")
        .setMessage("This app needs location permission to get your current location. Please grant permission in Settings.")
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
