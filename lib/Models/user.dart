import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  int UserID;

  @HiveField(1)
  String firstname;

  @HiveField(2)
  String lastname;

  @HiveField(3)
  String email;

  @HiveField(4)
  String telephone;

  @HiveField(5)
  String note;

  @HiveField(6)
  String profession;

  @HiveField(7)
  String profileImagePath;

  @HiveField(8)
  String ville;

  @HiveField(9)
  bool bloc;

  @HiveField(10)
  String fullname = "";

  @HiveField(11)
  String? typeUser;

  @HiveField(12)
  String? telephone2;

  @HiveField(13)
  String? telephone3;

  User(
      {required this.UserID,
      required this.firstname,
      required this.lastname,
      required this.email,
      required this.telephone,
      this.telephone2,
      this.telephone3,
      required this.note,
      required this.profession,
      required this.profileImagePath,
      required this.ville,
      required this.bloc,
      this.typeUser}) {
    fullname = firstname + " " + lastname;
  }
  void updateFullName() {
    fullname = firstname + " " + lastname;
  }
}
