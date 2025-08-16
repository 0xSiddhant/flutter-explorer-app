package com.siddhant.the_router

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import okhttp3.*
import java.io.IOException
import java.util.concurrent.TimeUnit

/**
 * Service class for handling network operations
 * Includes GET, POST, PUT, DELETE API calls using OkHttp
 */
class NetworkService {
  
  private val client = OkHttpClient.Builder()
    .connectTimeout(30, TimeUnit.SECONDS)
    .readTimeout(30, TimeUnit.SECONDS)
    .writeTimeout(30, TimeUnit.SECONDS)
    .build()

  fun handleMethodCall(call: MethodCall, result: MethodChannel.Result, activity: MainActivity) {
    when (call.method) {
      "getRequest" -> {
        val url = call.argument<String>("url") ?: ""
        val headers = call.argument<Map<String, String>>("headers") ?: emptyMap()
        performGetRequest(url, headers, result)
      }
      "postRequest" -> {
        val url = call.argument<String>("url") ?: ""
        val headers = call.argument<Map<String, String>>("headers") ?: emptyMap()
        val body = call.argument<String>("body") ?: ""
        performPostRequest(url, headers, body, result)
      }
      "putRequest" -> {
        val url = call.argument<String>("url") ?: ""
        val headers = call.argument<Map<String, String>>("headers") ?: emptyMap()
        val body = call.argument<String>("body") ?: ""
        performPutRequest(url, headers, body, result)
      }
      "deleteRequest" -> {
        val url = call.argument<String>("url") ?: ""
        val headers = call.argument<Map<String, String>>("headers") ?: emptyMap()
        performDeleteRequest(url, headers, result)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  private fun performGetRequest(url: String, headers: Map<String, String>, result: MethodChannel.Result) {
    val requestBuilder = Request.Builder().url(url)
    
    headers.forEach { (key, value) ->
      requestBuilder.addHeader(key, value)
    }
    
    val request = requestBuilder.build()
    
    client.newCall(request).enqueue(object : Callback {
      override fun onFailure(call: Call, e: IOException) {
        result.success(mapOf(
          "success" to false,
          "error" to "Network error: ${e.message}",
          "statusCode" to -1
        ))
      }

      override fun onResponse(call: Call, response: Response) {
        val responseBody = response.body?.string() ?: ""
        result.success(mapOf(
          "success" to response.isSuccessful,
          "statusCode" to response.code,
          "headers" to response.headers.toMap(),
          "body" to responseBody,
          "url" to url
        ))
      }
    })
  }

  private fun performPostRequest(url: String, headers: Map<String, String>, body: String, result: MethodChannel.Result) {
    val requestBody = RequestBody.create(MediaType.get("application/json; charset=utf-8"), body)
    val requestBuilder = Request.Builder().url(url).post(requestBody)
    
    headers.forEach { (key, value) ->
      requestBuilder.addHeader(key, value)
    }
    
    val request = requestBuilder.build()
    
    client.newCall(request).enqueue(object : Callback {
      override fun onFailure(call: Call, e: IOException) {
        result.success(mapOf(
          "success" to false,
          "error" to "Network error: ${e.message}",
          "statusCode" to -1
        ))
      }

      override fun onResponse(call: Call, response: Response) {
        val responseBody = response.body?.string() ?: ""
        result.success(mapOf(
          "success" to response.isSuccessful,
          "statusCode" to response.code,
          "headers" to response.headers.toMap(),
          "body" to responseBody,
          "url" to url
        ))
      }
    })
  }

  private fun performPutRequest(url: String, headers: Map<String, String>, body: String, result: MethodChannel.Result) {
    val requestBody = RequestBody.create(MediaType.get("application/json; charset=utf-8"), body)
    val requestBuilder = Request.Builder().url(url).put(requestBody)
    
    headers.forEach { (key, value) ->
      requestBuilder.addHeader(key, value)
    }
    
    val request = requestBuilder.build()
    
    client.newCall(request).enqueue(object : Callback {
      override fun onFailure(call: Call, e: IOException) {
        result.success(mapOf(
          "success" to false,
          "error" to "Network error: ${e.message}",
          "statusCode" to -1
        ))
      }

      override fun onResponse(call: Call, response: Response) {
        val responseBody = response.body?.string() ?: ""
        result.success(mapOf(
          "success" to response.isSuccessful,
          "statusCode" to response.code,
          "headers" to response.headers.toMap(),
          "body" to responseBody,
          "url" to url
        ))
      }
    })
  }

  private fun performDeleteRequest(url: String, headers: Map<String, String>, result: MethodChannel.Result) {
    val requestBuilder = Request.Builder().url(url).delete()
    
    headers.forEach { (key, value) ->
      requestBuilder.addHeader(key, value)
    }
    
    val request = requestBuilder.build()
    
    client.newCall(request).enqueue(object : Callback {
      override fun onFailure(call: Call, e: IOException) {
        result.success(mapOf(
          "success" to false,
          "error" to "Network error: ${e.message}",
          "statusCode" to -1
        ))
      }

      override fun onResponse(call: Call, response: Response) {
        val responseBody = response.body?.string() ?: ""
        result.success(mapOf(
          "success" to response.isSuccessful,
          "statusCode" to response.code,
          "headers" to response.headers.toMap(),
          "body" to responseBody,
          "url" to url
        ))
      }
    })
  }
}
