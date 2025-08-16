package com.siddhant.the_router

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import android.util.Log
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.*

/**
 * Android implementation of date change observer
 * Monitors system date changes using BroadcastReceiver
 */
class DateChangeObserver(
    private val context: Context,
    private val methodChannel: MethodChannel,
    private val eventChannel: EventChannel
) : MethodChannel.MethodCallHandler, EventChannel.StreamHandler {

    companion object {
        private const val TAG = "DateChangeObserver"
        private const val METHOD_INITIALIZE = "initialize"
        private const val METHOD_DISPOSE = "dispose"
    }

    private var eventSink: EventChannel.EventSink? = null
    private var dateChangeReceiver: BroadcastReceiver? = null
    private var lastKnownDate: Date = Date()

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            METHOD_INITIALIZE -> {
                initializeDateObserver()
                result.success(null)
            }
            METHOD_DISPOSE -> {
                disposeDateObserver()
                result.success(null)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
        Log.d(TAG, "Date change event listener started")
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
        Log.d(TAG, "Date change event listener cancelled")
    }

    private fun initializeDateObserver() {
        try {
            // Store current date as reference
            lastKnownDate = Date()
            
            // Create and register broadcast receiver for date changes
            dateChangeReceiver = object : BroadcastReceiver() {
                override fun onReceive(context: Context?, intent: Intent?) {
                    when (intent?.action) {
                        Intent.ACTION_TIME_CHANGED,
                        Intent.ACTION_TIMEZONE_CHANGED,
                        Intent.ACTION_DATE_CHANGED -> {
                            handleDateChange()
                        }
                    }
                }
            }

            // Register the receiver with appropriate filters
            val filter = IntentFilter().apply {
                addAction(Intent.ACTION_TIME_CHANGED)
                addAction(Intent.ACTION_TIMEZONE_CHANGED)
                addAction(Intent.ACTION_DATE_CHANGED)
            }

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                context.registerReceiver(
                    dateChangeReceiver,
                    filter,
                    Context.RECEIVER_NOT_EXPORTED
                )
            } else {
                context.registerReceiver(dateChangeReceiver, filter)
            }

            Log.d(TAG, "Date change observer initialized successfully")
        } catch (e: Exception) {
            Log.e(TAG, "Failed to initialize date change observer", e)
        }
    }

    private fun handleDateChange() {
        try {
            val currentDate = Date()
            
            // Check if date actually changed (not just time)
            if (isDateChanged(currentDate)) {
                Log.d(TAG, "Date change detected: ${currentDate}")
                
                // Send event to Flutter
                eventSink?.success(mapOf(
                    "timestamp" to currentDate.time,
                    "date" to currentDate.toString()
                ))
                
                lastKnownDate = currentDate
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error handling date change", e)
        }
    }

    private fun isDateChanged(currentDate: Date): Boolean {
        val calendar1 = Calendar.getInstance().apply { time = lastKnownDate }
        val calendar2 = Calendar.getInstance().apply { time = currentDate }
        
        return calendar1.get(Calendar.YEAR) != calendar2.get(Calendar.YEAR) ||
               calendar1.get(Calendar.DAY_OF_YEAR) != calendar2.get(Calendar.DAY_OF_YEAR)
    }

    private fun disposeDateObserver() {
        try {
            // Unregister broadcast receiver
            dateChangeReceiver?.let { receiver ->
                context.unregisterReceiver(receiver)
                dateChangeReceiver = null
            }
            
            // Clear event sink
            eventSink = null
            
            Log.d(TAG, "Date change observer disposed successfully")
        } catch (e: Exception) {
            Log.e(TAG, "Error disposing date change observer", e)
        }
    }
}
