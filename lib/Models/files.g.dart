// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'files.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FilesAdapter extends TypeAdapter<Files> {
  @override
  final int typeId = 4;

  @override
  Files read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Files(
      fileID: fields[0] as int,
      fileName: fields[1] as String,
      filePath: fields[2] as String,
      userID: fields[3] as int,
      bloc: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Files obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.fileID)
      ..writeByte(1)
      ..write(obj.fileName)
      ..writeByte(2)
      ..write(obj.filePath)
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
      other is FilesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
