import 'package:avocatapp/Models/user.dart';
import 'package:avocatapp/pages/clients_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';

class ClientsListDB {
  List<User> ClientsList = [];

  //open the box
  // clients databases
  // listClientsBox   /  imagesClientsBox   /  videosClientsBox   /  filesClientsBox
  final clientlistBox = Hive.box('listClientsBox');

  // var videosClientsBox = Hive.openBox('videosClientsBox');
  // var filesClientsBox = Hive.openBox('filesClientsBox');

  // first time open the app ever
  void createInitiaData() {
    ClientsList = [];
  }

  //load the data from the database
  void loadData() {
    // print(clientlistBox.get("listClientsBox"));
    // ClientsList = (clientlistBox.get("listClientsBox"));
    var list = clientlistBox.get("listClientsBox");
    ClientsList = List<User>.from(list)
        .where((element) => element.bloc == false)
        .toList();
    // ClientsList = list;
  }

  //update the data from the database
  void updateDatabase() {
    clientlistBox.put("listClientsBox", ClientsList);
  }

  String getAllEmails() {
    String emails = "";
    for (int i = 0; i < ClientsList.length; i++) {
      emails = ClientsList[i].email + ",";
    }
    return emails;
  }
}
