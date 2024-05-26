import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'images.g.dart';

@HiveType(typeId: 2)
class Images {
  @HiveField(0)
  int imageID;

  @HiveField(1)
  String imageName;

  @HiveField(2)
  String ImagePath;

  @HiveField(3)
  int userID;

  @HiveField(4)
  bool bloc;

  Images({
    required this.imageID,
    required this.imageName,
    required this.ImagePath,
    required this.userID,
    required this.bloc,
  });
}
