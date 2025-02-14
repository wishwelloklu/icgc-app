// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sermon_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SermonModelAdapter extends TypeAdapter<SermonModel> {
  @override
  final int typeId = 2;

  @override
  SermonModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SermonModel(
      title: fields[0] as String,
      subTitle: fields[1] as String,
      tags: (fields[4] as List?)?.cast<Tag>(),
      sample: fields[2] as String,
      id: fields[5] as String?,
      color: fields[3] as ColorModel?,
    );
  }

  @override
  void write(BinaryWriter writer, SermonModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.subTitle)
      ..writeByte(2)
      ..write(obj.sample)
      ..writeByte(3)
      ..write(obj.color)
      ..writeByte(4)
      ..write(obj.tags)
      ..writeByte(5)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SermonModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
