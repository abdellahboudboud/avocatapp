import 'package:avocatapp/Models/images.dart';
import 'package:avocatapp/Models/videos.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';

class ClientsVideosDB {
  List<Videos> videosList = [];

  var videosClientsBox = Hive.box('videosClientsBox');

  // first time open the app ever
  void createInitiaData() {
    videosList = [];
  }

  //load the data from the database
  void loadData() {
    var list = videosClientsBox.get('videosClientsBox');
    if (list != null) {
      videosList = List<Videos>.from(list)
          .where((element) => element.bloc == false)
          .toList();
    }
  }

  //update the data from the database
  void updateDatabase() {
    videosClientsBox.put('videosClientsBox', videosList);
  }
}
