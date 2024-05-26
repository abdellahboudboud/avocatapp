import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'videos.g.dart';

@HiveType(typeId: 3)
class Videos {
  @HiveField(0)
  int videoID;

  @HiveField(1)
  String videoName;

  @HiveField(2)
  String videoPath;

  @HiveField(3)
  int userID;

  @HiveField(4)
  bool bloc;

  Videos({
    required this.videoID,
    required this.videoName,
    required this.videoPath,
    required this.userID,
    required this.bloc,
  });
}
