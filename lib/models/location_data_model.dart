import 'package:hive/hive.dart';
part 'location_data_model.g.dart';

@HiveType(typeId: 1)
class LocationDataModel {
  LocationDataModel({required this.longitute, required this.latitude, required this.timestamp, required this.accuracy, required this.isTracking});

  @HiveField(0)
  double longitute;

  @HiveField(1)
  double latitude;

  @HiveField(2)
  DateTime timestamp;

  @HiveField(3)
  double accuracy;

  @HiveField(4)
  bool isTracking;

  @override
  String toString() {
    return '$longitute: $latitude: $timestamp: $accuracy';
  }
}