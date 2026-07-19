import 'package:hive_flutter/hive_flutter.dart';
import 'package:tracker/constants/hive_constant.dart';
import 'package:tracker/models/location_data_model.dart';

class HiveService {
  HiveService._();

  static final HiveService instance = HiveService._();

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

    await Hive.initFlutter();
    Hive.registerAdapter(LocationDataModelAdapter());
    await Hive.openBox<LocationDataModel>(HiveConstant.locationDataBox);
    await Hive.openBox<bool>(HiveConstant.trackApp);
    _initialized = true;
  }

  Box<T> box<T>(String name) => Hive.box<T>(name);

  Future<Box<T>> openBox<T>(String name) async {
    if (Hive.isBoxOpen(name)) {
      return Hive.box<T>(name);
    }

    return await Hive.openBox<T>(name);
  }

  Future<void> close() async {
    await Hive.close();
    _initialized = false;
  }

  Future<void> deleteBox(String name) async {
    await Hive.deleteBoxFromDisk(name);
  }
}
