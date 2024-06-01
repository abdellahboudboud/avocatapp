import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'meetings.g.dart';

@HiveType(typeId: 5)
class Meetings {
  @HiveField(0)
  int MeetingID;

  @HiveField(1)
  String MeetingName;

  @HiveField(2)
  String Title;

  @HiveField(3)
  String dateMeeting;

  @HiveField(4)
  String Location;

  @HiveField(5)
  bool bloc;

  Meetings({
    required this.MeetingID,
    required this.MeetingName,
    required this.Title,
    required this.dateMeeting,
    required this.Location,
    required this.bloc,
  });
}
