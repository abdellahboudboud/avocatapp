// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'images.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImagesAdapter extends TypeAdapter<Images> {
  @override
  final int typeId = 2;

  @override
  Images read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Images(
      imageID: fields[0] as int,
      imageName: fields[1] as String,
      ImagePath: fields[2] as String,
      userID: fields[3] as int,
      bloc: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Images obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.imageID)
      ..writeByte(1)
      ..write(obj.imageName)
      ..writeByte(2)
      ..write(obj.ImagePath)
      ..writeByte(3)
      ..write(obj.userID)
      ..writeByte(4)
      ..write(obj.bloc);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImagesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
