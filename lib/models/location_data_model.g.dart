// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationDataModelAdapter extends TypeAdapter<LocationDataModel> {
  @override
  final int typeId = 1;

  @override
  LocationDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocationDataModel(
      longitute: fields[0] as double,
      latitude: fields[1] as double,
      timestamp: fields[2] as DateTime,
      accuracy: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, LocationDataModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.longitute)
      ..writeByte(1)
      ..write(obj.latitude)
      ..writeByte(2)
      ..write(obj.timestamp)
      ..writeByte(3)
      ..write(obj.accuracy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
