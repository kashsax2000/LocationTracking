import 'dart:developer';

import 'package:flutter/services.dart';

class BatteryService {
  static const MethodChannel _channel = MethodChannel('battery_channel');

  static Future<int?> getBatteryLevel() async {
    try {
      final int batteryLevel = await _channel.invokeMethod('getBatteryLevel');
      return batteryLevel;
    } on PlatformException catch (e) {
      log("Failed to get battery level: ${e.message}");
      return null;
    }
  }
}
