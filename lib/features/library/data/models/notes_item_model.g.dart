// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotesItemModelAdapter extends TypeAdapter<NotesItemModel> {
  @override
  final int typeId = 0;

  @override
  NotesItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotesItemModel(
      title: fields[0] as String,
      note: fields[1] as String,
      dateTime: fields[2] as DateTime,
      id: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, NotesItemModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.note)
      ..writeByte(2)
      ..write(obj.dateTime)
      ..writeByte(3)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotesItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
