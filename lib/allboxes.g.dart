// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allboxes.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AllBoxesAdapter extends TypeAdapter<AllBoxes> {
  @override
  final int typeId = 2;

  @override
  AllBoxes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AllBoxes(
      name: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AllBoxes obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllBoxesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
