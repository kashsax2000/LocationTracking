import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:tracker/models/location_data_model.dart';
import 'package:tracker/services/tracking_storage_service.dart';
import 'package:tracker/viewmodels/base_provider.dart';

class LocationHistoryViewmodel extends BaseProvider {
  LocationHistoryViewmodel({TrackingStorageService? storageService})
    : _storageService = storageService ?? TrackingStorageService();

  final TrackingStorageService _storageService;

  late Box<LocationDataModel> _box;

  List<LocationDataModel> locationData = [];
  StreamSubscription? _boxListener;

  Future<void> init() async {
    _box = await _storageService.locationBox();

    locationData = await _storageService.loadLocations();
    _boxListener = _box.watch().listen((_) {
      locationData = _box.values.toList();
      notifyListeners();
    });
    notifyListeners();
  }

  @override
  void dispose() {
    _boxListener?.cancel();
    super.dispose();
  }
}
