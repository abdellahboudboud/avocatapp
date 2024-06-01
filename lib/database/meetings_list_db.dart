import 'package:avocatapp/Models/meetings.dart';
import 'package:avocatapp/Models/user.dart';
import 'package:avocatapp/pages/clients_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';

class MeetingsListDB {
  List<Meetings> MeetingsList = [];

  //open the box
  // clients databases
  // listClientsBox   /  imagesClientsBox   /  videosClientsBox   /  filesClientsBox
  final MeetingsBox = Hive.box('MeetingsBox');

  // var videosClientsBox = Hive.openBox('videosClientsBox');
  // var filesClientsBox = Hive.openBox('filesClientsBox');

  // first time open the app ever
  void createInitiaData() {
    MeetingsList = [];
  }

  //load the data from the database
  void loadData() {
    // print(clientlistBox.get("listClientsBox"));
    // ClientsList = (clientlistBox.get("listClientsBox"));
    var list = MeetingsBox.get("MeetingsBox");
    if (list != null) {
      MeetingsList = List<Meetings>.from(list)
        .where((element) => element.bloc == false)
        .toList();
    }
    
    // ClientsList = list;
  }

  //update the data from the database
  void updateDatabase() {
    MeetingsBox.put("MeetingsBox", MeetingsList);
  }

}
