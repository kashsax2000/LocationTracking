import 'package:hive/hive.dart';
import 'package:tracker/constants/hive_constant.dart';
import 'package:tracker/models/location_data_model.dart';
import 'package:tracker/services/hive_service.dart';

class TrackingStorageService {
  TrackingStorageService({HiveService? hiveService})
    : _hiveService = hiveService ?? HiveService.instance;

  final HiveService _hiveService;

  Future<Box<LocationDataModel>> locationBox() async {
    return _hiveService.openBox<LocationDataModel>(HiveConstant.locationDataBox);
  }

  Future<Box<dynamic>> appBox() async {
    return _hiveService.openBox<dynamic>(HiveConstant.trackApp);
  }

  Future<bool> getTrackingState() async {
    final box = await appBox();
    return box.get(HiveConstant.isTracking, defaultValue: false);
  }

  Future<void> setTrackingState(bool tracking) async {
    final box = await appBox();
    await box.put(HiveConstant.isTracking, tracking);
  }

  Future<void> saveLocation(LocationDataModel location) async {
    final box = await locationBox();
    await box.add(location);
  }

  Future<List<LocationDataModel>> loadLocations() async {
    final box = await locationBox();
    return box.values.toList();
  }
}
