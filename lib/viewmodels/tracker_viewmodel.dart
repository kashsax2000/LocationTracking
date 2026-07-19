import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tracker/constants/string_constant.dart';
import 'package:tracker/models/location_data_model.dart';
import 'package:tracker/services/background_location_services.dart';
import 'package:tracker/services/battery_service.dart';
import 'package:tracker/services/tracking_storage_service.dart';
import 'package:tracker/viewmodels/base_provider.dart';

class TrackerViewmodel extends BaseProvider {
  TrackerViewmodel({TrackingStorageService? storageService})
    : _storageService = storageService ?? TrackingStorageService() {
        initialize();
      }

  final TrackingStorageService _storageService;

  StreamSubscription<Position>? _positionStreamSubscription;
  String locationStatus = StringConstant.notTracking;

  Timer? _trackingTimer;
  bool isTracking = false;
  int battery = 0;

  Future<void> initialize() async {
    isTracking = await _storageService.getTrackingState();

    locationStatus = isTracking
        ? StringConstant.trackingStarted
        : StringConstant.notTracking;

    await getBatteryLevel();
    notifyListeners();
  }

  Future<void> setTrackingState(bool tracking) async {
    await _storageService.setTrackingState(tracking);
    isTracking = tracking;
    notifyListeners();
  }

  Future<void> getBatteryLevel() async {
    battery = await BatteryService.getBatteryLevel() ?? 0;
    notifyListeners();
  }

  Future<void> startTracking() async {
    if (isTracking) {
      await stopTracking();
      return;
    }

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      locationStatus = StringConstant.locationServiceAreDisabled;
      notifyListeners();
      return;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        locationStatus = StringConstant.locationPermissionAreDenied;
        notifyListeners();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      locationStatus = StringConstant.permissionPermanentlyDenied;
      notifyListeners();
      return;
    }

    await setTrackingState(true);
    locationStatus = StringConstant.trackingStarted;

    await BackgroundLocationService.start();

    notifyListeners();

    await trackCurrentLocation();

    _trackingTimer = Timer.periodic(const Duration(seconds: 60), (_) async {
      await trackCurrentLocation();
    });

    await getBatteryLevel();
  }

  Future<void> trackCurrentLocation() async {
    final locationSettings = _buildLocationSettings();

    final pos = await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );

    locationStatus =
        'Latitude: ${pos.latitude}\nLongitude: ${pos.longitude}\nAccuracy: ${pos.accuracy}';

    await _storageService.saveLocation(
      LocationDataModel(
        longitute: pos.longitude,
        latitude: pos.latitude,
        timestamp: pos.timestamp,
        accuracy: pos.accuracy,
      ),
    );

    notifyListeners();
  }

  Future<void> stopTracking() async {
    _trackingTimer?.cancel();
    _trackingTimer = null;
    await setTrackingState(false);
    locationStatus = StringConstant.trackingStopped;
    await BackgroundLocationService.stop();
    notifyListeners();
  }

  LocationSettings _buildLocationSettings() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 0,
        forceLocationManager: false,
      );
    }

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
        distanceFilter: 0,
        pauseLocationUpdatesAutomatically: false,
        showBackgroundLocationIndicator: true,
      );
    }

    return const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0,
    );
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    _trackingTimer?.cancel();
    super.dispose();
  }
}
