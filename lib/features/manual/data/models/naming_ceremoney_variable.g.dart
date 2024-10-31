// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'naming_ceremoney_variable.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NamingCeremoneyVariableAdapter
    extends TypeAdapter<NamingCeremoneyVariable> {
  @override
  final int typeId = 1;

  @override
  NamingCeremoneyVariable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NamingCeremoneyVariable(
      parent: fields[2] as String?,
      child: fields[0] as String,
      father: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NamingCeremoneyVariable obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.child)
      ..writeByte(1)
      ..write(obj.father)
      ..writeByte(2)
      ..write(obj.parent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NamingCeremoneyVariableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
