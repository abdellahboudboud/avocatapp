import 'package:avocatapp/Models/files.dart';
import 'package:avocatapp/Models/images.dart';
import 'package:avocatapp/Models/videos.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';

class ClientsFilesDB {
  List<Files> filesList = [];

  var filesClientsBox = Hive.box('filesClientsBox');

  // first time open the app ever
  void createInitiaData() {
    filesList = [];
  }

  //load the data from the database
  void loadData() {
    var list = filesClientsBox.get('filesClientsBox');
    if (list != null) {
      filesList = List<Files>.from(list)
          .where((element) => element.bloc == false)
          .toList();
    }
  }

  //update the data from the database
  void updateDatabase() {
    filesClientsBox.put('filesClientsBox', filesList);
  }
}
