import 'package:avocatapp/Models/images.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';

class ClientsImagesDB {
  List<Images> imagesList = [];

  var imagesClientsBox = Hive.box('imagesClientsBox');

  // first time open the app ever
  void createInitiaData() {
    imagesList = [];
  }

  //load the data from the database
  void loadData() {
    var list = imagesClientsBox.get('imagesClientsBox');
    if (list != null) {
      imagesList = List<Images>.from(list)
          .where((element) => element.bloc == false)
          .toList();
    }
  }

  //update the data from the database
  void updateDatabase() {
    imagesClientsBox.put('imagesClientsBox', imagesList);
  }
}
