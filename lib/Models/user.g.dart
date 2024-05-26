// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 1;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      UserID: fields[0] as int,
      firstname: fields[1] as String,
      lastname: fields[2] as String,
      email: fields[3] as String,
      telephone: fields[4] as String,
      telephone2: fields[12] as String?,
      telephone3: fields[13] as String?,
      note: fields[5] as String,
      profession: fields[6] as String,
      profileImagePath: fields[7] as String,
      ville: fields[8] as String,
      bloc: fields[9] as bool,
      typeUser: fields[11] as String?,
    )..fullname = fields[10] as String;
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.UserID)
      ..writeByte(1)
      ..write(obj.firstname)
      ..writeByte(2)
      ..write(obj.lastname)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.telephone)
      ..writeByte(5)
      ..write(obj.note)
      ..writeByte(6)
      ..write(obj.profession)
      ..writeByte(7)
      ..write(obj.profileImagePath)
      ..writeByte(8)
      ..write(obj.ville)
      ..writeByte(9)
      ..write(obj.bloc)
      ..writeByte(10)
      ..write(obj.fullname)
      ..writeByte(11)
      ..write(obj.typeUser)
      ..writeByte(12)
      ..write(obj.telephone2)
      ..writeByte(13)
      ..write(obj.telephone3);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
