// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todozz.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task()
      ..venue = fields[0] as String
      ..time = fields[1] as String
      ..lecture = fields[2] as String
      ..isCompleted = fields[3] as bool;
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.venue)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.lecture)
      ..writeByte(3)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
