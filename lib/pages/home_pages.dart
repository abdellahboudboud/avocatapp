// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:avocatapp/Models/user.dart';
import 'package:avocatapp/componenets/testimenial_items.dart';
import 'package:avocatapp/database/clients_images_db.dart';
import 'package:avocatapp/database/clients_list_db.dart';
import 'package:avocatapp/database/meetings_list_db.dart';
import 'package:avocatapp/pages/clients_page.dart';
import 'package:avocatapp/pages/meetings_page.dart';
import 'package:avocatapp/pages/send_email_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _homepageState();
}

class _homepageState extends State<Homepage> {
  final clientlistBox = Hive.box('listClientsBox');
  final clientImagelistBox = Hive.box('imagesClientsBox');
// database functions
  ClientsListDB db = ClientsListDB();
  MeetingsListDB db_Meetings = MeetingsListDB();
  ClientsImagesDB _imagesDB = ClientsImagesDB();

  @override
  void initState() {
    //if this is the first time opening the app then create default data
    // client info list db
    if (db.clientlistBox.get("listClientsBox") == null) {
      db.createInitiaData();
      db.updateDatabase();
    } else {
      db.loadData();
    }

    // client images list db
    if (_imagesDB.imagesClientsBox.get("imagesClientsBox") == null) {
      _imagesDB.createInitiaData();
      _imagesDB.updateDatabase();
    } else {
      _imagesDB.loadData();
    }

    // meetings  list db
    if (db_Meetings.MeetingsBox.get("MeetingsBox") == null) {
      db_Meetings.createInitiaData();
      db_Meetings.updateDatabase();
    } else {
      db_Meetings.loadData();
    }

    // TODO: implement initState
    super.initState();
  }

  List testimenialsList = [
    ["الموكلــون", "lib/images/cllients2.png"],
    ["المحـامــون", "lib/images/male-lawyer.png"],
    ["المحاميـات", "lib/images/female-lawyer.png"],
    ["البريـد", "lib/images/email.png"],
    ["النقبــاء", "lib/images/nokaba2.png"],
    ["الجلســات", "lib/images/mahkama.png"],
  ];

// access the page dependes on the index of the page
/*

    0: clients

    1: lawyers man

    2: lawyers female

    3: notification

    4: nokaba2

    5: jalasat mahkama

*/
  void _selectedSection(int index) {
    setState(() {
      if (index == 0) {
        /* 
        
            0: CLIENTS PAGE
        
        */
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ClientsPage(
                    db: db,
                    typeUser: "0",
                    title: "الموكلــون",
                    buttonName: "موكل جديد",
                    buttonIcon: Icons.person_add,
                    searchText: "... ابحث عن موكل",
                    job: "")));
      } else if (index == 1) {
        /* 
        
            1: LAWYER MALE
        
        */
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ClientsPage(
                      db: db,
                      typeUser: "1",
                      title: "المحـامــون",
                      buttonName: "محامـي جديد",
                      buttonIcon: Icons.person_add,
                      searchText: "... ابحث عن محامـي",
                      job: "محامي",
                    )));
      } else if (index == 2) {
        /* 
        
            2: LAWYER FEMALE
        
        */
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ClientsPage(
                      db: db,
                      typeUser: "2",
                      title: "المحـاميــات",
                      buttonName: "محـاميـة جديد",
                      buttonIcon: Icons.person_add,
                      searchText: "... ابحث عن محـاميـة",
                      job: "محامية",
                    )));
      } else if (index == 3) {
        /* 
        
           3: notification
        
        */
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SendEmailPage()));
      } else if (index == 4) {
        /* 
        
            4: NOKABA2
        
        */
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ClientsPage(
                      db: db,
                      typeUser: "4",
                      title: "النقبــاء",
                      buttonName: "نقيـب جديد",
                      buttonIcon: Icons.person_add,
                      searchText: "... ابحث عن نقيـب",
                      job: "نقيـب",
                    )));
      }else if (index == 5) {
        /* 
        
            4: JALASAT MAHKAMA
        
        */
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MeetingsPage(
                      db: db_Meetings,
                      typeUser: "5",
                      title: "الجلســات",
                      buttonName: "جلســة جديد",
                      buttonIcon: Icons.lock_clock,
                      searchText: "... ابحث عن جلســة",
                      job: "جلســة",
                    )));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
          child: Column(
            children: [
              Container(
                  alignment: Alignment.topRight,
                  //decoration: BoxDecoration(
                  //color: Theme.of(context).colorScheme.secondary),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 50, left: 10, right: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("مرحبا بك",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontFamily: "Arabic",
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary)),
                        Text("عبد القادر البنيحياتي",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: "Arabic",
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                      ],
                    ),
                  )),
              //list des button
              Expanded(
                child: ListView.builder(
                    itemCount: testimenialsList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _selectedSection(index);
                        },
                        child: TestimenialItem(
                            name: testimenialsList[index][0],
                            imagePath: testimenialsList[index][1]),
                      );
                    }),
              )
            ],
          ),
        ));
  }
}
