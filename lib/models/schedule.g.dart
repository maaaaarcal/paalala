// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScheduleAdapter extends TypeAdapter<Schedule> {
  @override
  final int typeId = 1;

  @override
  Schedule read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Schedule(
      frequency: fields[0] as Frequency,
      taskDeadline: fields[1] as TZDateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Schedule obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.frequency)
      ..writeByte(1)
      ..write(obj.taskDeadline);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FrequencyAdapter extends TypeAdapter<Frequency> {
  @override
  final int typeId = 2;

  @override
  Frequency read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Frequency.never;
      case 1:
        return Frequency.hourly;
      case 2:
        return Frequency.daily;
      case 3:
        return Frequency.weekly;
      case 4:
        return Frequency.monthly;
      case 5:
        return Frequency.yearly;
      default:
        return Frequency.never;
    }
  }

  @override
  void write(BinaryWriter writer, Frequency obj) {
    switch (obj) {
      case Frequency.never:
        writer.writeByte(0);
        break;
      case Frequency.hourly:
        writer.writeByte(1);
        break;
      case Frequency.daily:
        writer.writeByte(2);
        break;
      case Frequency.weekly:
        writer.writeByte(3);
        break;
      case Frequency.monthly:
        writer.writeByte(4);
        break;
      case Frequency.yearly:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FrequencyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
