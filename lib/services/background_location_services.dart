import 'dart:developer';

import 'package:flutter_background_geolocation/flutter_background_geolocation.dart';
import 'package:tracker/constants/hive_constant.dart';
import 'package:tracker/services/hive_service.dart';

import '../models/location_data_model.dart';

class BackgroundLocationService {
  static final locationBox = HiveService.instance.box<LocationDataModel>(
    HiveConstant.locationDataBox,
  );

  static Future<void> init() async {
    final appBox = await HiveService.instance.openBox('app');

    BackgroundGeolocation.onLocation((Location location) async {
      final coords = location.coords;
      final isTracking = appBox.get('isTracking', defaultValue: false);

      log("LAT: ${coords.latitude}, LNG: ${coords.longitude}");

      // Save to Hive here
      await locationBox.add(
        LocationDataModel(
          longitute: coords.longitude,
          latitude: coords.latitude,
          timestamp: DateTime.timestamp(),
          accuracy: coords.accuracy,
          isTracking: isTracking,
        ),
      );
    });

    await BackgroundGeolocation.ready(
      Config(
        desiredAccuracy: Config.DESIRED_ACCURACY_HIGH,
        distanceFilter: 10,
        stopOnTerminate: false,
        startOnBoot: true,
        enableHeadless: true,
        foregroundService: true,
      ),
    );
  }

  static Future<void> start() async {
    await BackgroundGeolocation.start();
  }

  static Future<void> stop() async {
    await BackgroundGeolocation.stop();
  }
}
