// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ColorModelAdapter extends TypeAdapter<ColorModel> {
  @override
  final int typeId = 3;

  @override
  ColorModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ColorModel(
      alpha: fields[0] as double,
      red: fields[1] as double,
      green: fields[2] as double,
      blue: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ColorModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.alpha)
      ..writeByte(1)
      ..write(obj.red)
      ..writeByte(2)
      ..write(obj.green)
      ..writeByte(3)
      ..write(obj.blue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ColorModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
