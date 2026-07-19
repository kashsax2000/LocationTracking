package com.example.tracker

import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import android.os.BatteryManager
import android.content.Context
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity(){

    private val CHANNEL = "battery_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->

            if (call.method == "getBatteryLevel") {
                val batteryManager =
                    getSystemService(Context.BATTERY_SERVICE) as BatteryManager

                val batteryLevel = batteryManager.getIntProperty(
                    BatteryManager.BATTERY_PROPERTY_CAPACITY
                )

                result.success(batteryLevel)
            } else {
                result.notImplemented()
            }
        }
    }
}
