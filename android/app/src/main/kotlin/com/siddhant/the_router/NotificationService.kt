package com.siddhant.the_router

import android.Manifest
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import androidx.core.app.NotificationCompat
import androidx.core.content.ContextCompat
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * Service class for handling notification operations
 * Includes creating, canceling notifications and permission management
 */
class NotificationService {
  
  fun handleMethodCall(call: MethodCall, result: MethodChannel.Result, activity: MainActivity) {
    when (call.method) {
      "showNotification" -> {
        val title = call.argument<String>("title") ?: "Notification"
        val message = call.argument<String>("message") ?: "This is a notification"
        val id = call.argument<Int>("id") ?: 1
        
        if (checkNotificationPermission(activity)) {
          val success = showNotification(activity, title, message, id)
          result.success(success)
        } else {
          requestNotificationPermissionWithCallback(activity) { granted ->
            if (granted) {
              val success = showNotification(activity, title, message, id)
              result.success(success)
            } else {
              result.success(false)
            }
          }
        }
      }
      "cancelNotification" -> {
        val id = call.argument<Int>("id") ?: 1
        val success = cancelNotification(activity, id)
        result.success(success)
      }
      "cancelAllNotifications" -> {
        val success = cancelAllNotifications(activity)
        result.success(success)
      }
      "checkNotificationPermission" -> {
        val hasPermission = checkNotificationPermission(activity)
        result.success(hasPermission)
      }
      "requestNotificationPermission" -> {
        requestNotificationPermissionWithCallback(activity) { granted ->
          result.success(granted)
        }
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  private fun showNotification(activity: MainActivity, title: String, message: String, id: Int): Boolean {
    return try {
      createNotificationChannel(activity)
      
      val intent = Intent(activity, MainActivity::class.java)
      val pendingIntent = PendingIntent.getActivity(activity, 0, intent, PendingIntent.FLAG_IMMUTABLE)
      
      val notification = NotificationCompat.Builder(activity, "flutter_explorer_channel")
        .setContentTitle(title)
        .setContentText(message)
        .setSmallIcon(android.R.drawable.ic_dialog_info)
        .setContentIntent(pendingIntent)
        .setPriority(NotificationCompat.PRIORITY_DEFAULT)
        .setAutoCancel(true)
        .build()

      val notificationManager = activity.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
      notificationManager.notify(id, notification)
      true
    } catch (e: Exception) {
      false
    }
  }

  private fun cancelNotification(activity: MainActivity, id: Int): Boolean {
    return try {
      val notificationManager = activity.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
      notificationManager.cancel(id)
      true
    } catch (e: Exception) {
      false
    }
  }

  private fun cancelAllNotifications(activity: MainActivity): Boolean {
    return try {
      val notificationManager = activity.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
      notificationManager.cancelAll()
      true
    } catch (e: Exception) {
      false
    }
  }

  private fun checkNotificationPermission(activity: MainActivity): Boolean {
    return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
      ContextCompat.checkSelfPermission(activity, Manifest.permission.POST_NOTIFICATIONS) == PackageManager.PERMISSION_GRANTED
    } else {
      true // For older versions, notifications are enabled by default
    }
  }

  private fun requestNotificationPermission(): Boolean {
    // In a real app, you'd request permission using ActivityCompat.requestPermissions
    // For demo purposes, we'll simulate permission granted
    return true
  }

  private fun requestNotificationPermissionWithCallback(activity: MainActivity, callback: (Boolean) -> Unit) {
    if (checkNotificationPermission(activity)) {
      callback(true)
      return
    }
    
    // In a real app, you'd use ActivityCompat.requestPermissions
    // For demo purposes, we'll simulate the permission request
    activity.runOnUiThread {
      val alert = android.app.AlertDialog.Builder(activity)
        .setTitle("Notification Permission")
        .setMessage("This app needs notification permission to show notifications. Please grant permission in Settings.")
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

  private fun createNotificationChannel(activity: MainActivity) {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
      val channel = NotificationChannel(
        "flutter_explorer_channel",
        "Flutter Explorer Notifications",
        NotificationManager.IMPORTANCE_DEFAULT
      ).apply {
        description = "Channel for Flutter Explorer app notifications"
      }
      
      val notificationManager = activity.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
      notificationManager.createNotificationChannel(channel)
    }
  }
}
