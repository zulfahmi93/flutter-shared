// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppLogAdapter extends TypeAdapter<AppLog> {
  @override
  final int typeId = 0;

  @override
  AppLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppLog(
      timestamp: fields[0] as DateTime,
      level: fields[1] as int,
      levelString: fields[2] as String,
      message: fields[3] as String,
      error: fields[4] as String?,
      stackTrace: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AppLog obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.timestamp)
      ..writeByte(1)
      ..write(obj.level)
      ..writeByte(2)
      ..write(obj.levelString)
      ..writeByte(3)
      ..write(obj.message)
      ..writeByte(4)
      ..write(obj.error)
      ..writeByte(5)
      ..write(obj.stackTrace);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
