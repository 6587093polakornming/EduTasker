// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'priority_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PriorityAdapter extends TypeAdapter<PriorityModel> {
  @override
  final int typeId = 1;

  @override
  PriorityModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PriorityModel(
      priority: fields[0] as String,
      date: fields[1] as DateTime?,
      taskname: fields[2] as String,
      description: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PriorityModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.priority)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.taskname)
      ..writeByte(3)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PriorityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
