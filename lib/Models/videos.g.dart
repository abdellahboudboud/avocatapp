// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'videos.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VideosAdapter extends TypeAdapter<Videos> {
  @override
  final int typeId = 3;

  @override
  Videos read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Videos(
      videoID: fields[0] as int,
      videoName: fields[1] as String,
      videoPath: fields[2] as String,
      userID: fields[3] as int,
      bloc: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Videos obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.videoID)
      ..writeByte(1)
      ..write(obj.videoName)
      ..writeByte(2)
      ..write(obj.videoPath)
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
      other is VideosAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
