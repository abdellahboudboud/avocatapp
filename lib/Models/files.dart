import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'files.g.dart';

@HiveType(typeId: 4)
class Files {
  @HiveField(0)
  int fileID;

  @HiveField(1)
  String fileName;

  @HiveField(2)
  String filePath;

  @HiveField(3)
  int userID;

  @HiveField(4)
  bool bloc;

  Files({
    required this.fileID,
    required this.fileName,
    required this.filePath,
    required this.userID,
    required this.bloc,
  });
}
