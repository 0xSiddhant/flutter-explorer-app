package com.siddhant.the_router

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileInputStream
import java.io.FileOutputStream
import java.io.IOException

/**
 * Service class for handling storage operations
 * Includes saving, loading, deleting data and storage information
 */
class StorageService {
  
  fun handleMethodCall(call: MethodCall, result: MethodChannel.Result, activity: MainActivity) {
    when (call.method) {
      "saveData" -> {
        val key = call.argument<String>("key") ?: ""
        val value = call.argument<String>("value") ?: ""
        val success = saveData(activity, key, value)
        result.success(success)
      }
      "loadData" -> {
        val key = call.argument<String>("key") ?: ""
        val data = loadData(activity, key)
        result.success(data)
      }
      "deleteData" -> {
        val key = call.argument<String>("key") ?: ""
        val success = deleteData(activity, key)
        result.success(success)
      }
      "clearAllData" -> {
        val success = clearAllData(activity)
        result.success(success)
      }
      "getStorageInfo" -> {
        val storageInfo = getStorageInfo(activity)
        result.success(storageInfo)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  private fun saveData(activity: MainActivity, key: String, value: String): Boolean {
    return try {
      val file = File(activity.filesDir, "flutter_storage.txt")
      val outputStream = FileOutputStream(file, true)
      outputStream.write("$key:$value\n".toByteArray())
      outputStream.close()
      true
    } catch (e: IOException) {
      false
    }
  }

  private fun loadData(activity: MainActivity, key: String): String? {
    return try {
      val file = File(activity.filesDir, "flutter_storage.txt")
      if (!file.exists()) return null
      
      val inputStream = FileInputStream(file)
      val content = inputStream.bufferedReader().use { it.readText() }
      inputStream.close()
      
      val lines = content.split("\n")
      for (line in lines) {
        if (line.startsWith("$key:")) {
          return line.substringAfter(":")
        }
      }
      null
    } catch (e: IOException) {
      null
    }
  }

  private fun deleteData(activity: MainActivity, key: String): Boolean {
    return try {
      val file = File(activity.filesDir, "flutter_storage.txt")
      if (!file.exists()) return true
      
      val inputStream = FileInputStream(file)
      val content = inputStream.bufferedReader().use { it.readText() }
      inputStream.close()
      
      val lines = content.split("\n").filter { !it.startsWith("$key:") }
      val newContent = lines.joinToString("\n")
      
      val outputStream = FileOutputStream(file, false)
      outputStream.write(newContent.toByteArray())
      outputStream.close()
      true
    } catch (e: IOException) {
      false
    }
  }

  private fun clearAllData(activity: MainActivity): Boolean {
    return try {
      val file = File(activity.filesDir, "flutter_storage.txt")
      if (file.exists()) {
        file.delete()
      }
      true
    } catch (e: Exception) {
      false
    }
  }

  private fun getStorageInfo(activity: MainActivity): Map<String, Any> {
    return try {
      val file = File(activity.filesDir, "flutter_storage.txt")
      val fileSize = if (file.exists()) file.length() else 0L
      val freeSpace = activity.filesDir.freeSpace
      val totalSpace = activity.filesDir.totalSpace
      
      mapOf(
        "success" to true,
        "fileSize" to fileSize,
        "freeSpace" to freeSpace,
        "totalSpace" to totalSpace,
        "usedSpace" to (totalSpace - freeSpace),
        "fileExists" to file.exists()
      )
    } catch (e: Exception) {
      mapOf(
        "success" to false,
        "error" to "Failed to get storage info: ${e.message}"
      )
    }
  }
}
