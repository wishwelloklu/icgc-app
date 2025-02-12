// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SampleModelAdapter extends TypeAdapter<SampleModel> {
  @override
  final int typeId = 2;

  @override
  SampleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SampleModel(
      title: fields[0] as String,
      sample: fields[2] as String,
      subTitle: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SampleModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.subTitle)
      ..writeByte(2)
      ..write(obj.sample);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SampleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
