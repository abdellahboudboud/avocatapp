// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meetings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MeetingsAdapter extends TypeAdapter<Meetings> {
  @override
  final int typeId = 5;

  @override
  Meetings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Meetings(
      MeetingID: fields[0] as int,
      MeetingName: fields[1] as String,
      Title: fields[2] as String,
      dateMeeting: fields[3] as String,
      Location: fields[4] as String,
      bloc: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Meetings obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.MeetingID)
      ..writeByte(1)
      ..write(obj.MeetingName)
      ..writeByte(2)
      ..write(obj.Title)
      ..writeByte(3)
      ..write(obj.dateMeeting)
      ..writeByte(4)
      ..write(obj.Location)
      ..writeByte(5)
      ..write(obj.bloc);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MeetingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
