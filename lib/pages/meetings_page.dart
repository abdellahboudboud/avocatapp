// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'package:avocatapp/Models/meetings.dart';
import 'package:avocatapp/Models/user.dart';
import 'package:avocatapp/componenets/header.dart';
import 'package:avocatapp/componenets/meeting_tile.dart';
import 'package:avocatapp/componenets/myflaoting_button.dart';
import 'package:avocatapp/componenets/searchbar.dart';
import 'package:avocatapp/componenets/user_tile.dart';
import 'package:avocatapp/database/clients_list_db.dart';
import 'package:avocatapp/database/meetings_list_db.dart';
import 'package:avocatapp/pages/add_client_page.dart';
import 'package:avocatapp/pages/add_meeting_page.dart';
import 'package:avocatapp/pages/client_profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';

class MeetingsPage extends StatefulWidget {
  MeetingsListDB db = MeetingsListDB();
  String typeUser;
  String title;
  String buttonName;
  IconData buttonIcon;
  String searchText;
  String? job;
  MeetingsPage(
      {super.key,
      required this.db,
      required this.typeUser,
      required this.title,
      required this.buttonName,
      required this.buttonIcon,
      required this.searchText,
      this.job});

  @override
  State<MeetingsPage> createState() => _MeetingsPageState();
}

class _MeetingsPageState extends State<MeetingsPage> {
  MeetingsListDB db = MeetingsListDB();
  List<Meetings> originalUsers = [];
  List<Meetings> _foundUser = [];

  @override
  void initState() {
    db = widget.db;
    originalUsers = db.MeetingsList;
        // db.MeetingsList.where((meeting) => meeting.blo == widget.typeUser)
        //     .toList();

    _foundUser = originalUsers;

    // TODO: implement initState
    super.initState();
  }

  // add new user to list of users
  void addNewMeeting() async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddMeetingPage(
            typeUser: widget.typeUser,
            buttonName: widget.buttonName,
            buttonIcon: widget.buttonIcon,
            job: widget.job,
          ),
        )).then((value) => setState(() {
          db.loadData();
          originalUsers = db.MeetingsList;
          _foundUser = originalUsers;
        }));

    // if (result != null) {
    //   if (bool.parse(result)) {
    //     setState(() {
    //       db.loadData();
    //       originalUsers =
    //           db.ClientsList.where((user) => user.typeUser == widget.typeUser)
    //               .toList();
    //       _foundUser = originalUsers;
    //       print("***************************************************");
    //       print(" refresh is happened ");
    //       print("***************************************************");
    //     });
    //   }
    // }
    // _foundUser.add(User(
    //     UserID: 1,
    //     firstname: "test",
    //     lastname: "test",
    //     email: "test@gmail.com",
    //     telephone: "06xxxxxxxx",
    //     note: "...",
    //     profession: "test job",
    //     profileImagePath: "lib/images/benyahyati.png",
    //     ville: "الرباط",
    //     bloc: false));
    // db.ClientsList = _foundUser;
    // db.updateDatabase();
    // db.loadData();
  }

  // search for user returns list of users
  void searchMeeting(String text) {
    List<Meetings> result;
    if (text.isEmpty) {
      result = originalUsers;
    } else {
      // result =
      result =
          originalUsers.where((meeting) => meeting.Title.contains(text)).toList();
      // print("hello : " + originalUsers[0].fullname);

      // db.ClientsList.where((user) => user.fullname.contains(text)).toList();
    }

    setState(() {
      _foundUser = result;
    });
  }

  // navigate to user profile page
  void selectedMeeting(int index) {
    // Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //             builder: (context) => AddMeetingPage(meet: _foundUser[index])))
    //     .then((value) => setState(() {
    //           db.loadData();
    //           originalUsers = db.ClientsList.where(
    //               (user) => user.typeUser == widget.typeUser).toList();
    //           _foundUser = originalUsers;
    //         }));
    // ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: MyfloatingButton(
        iconData: widget.buttonIcon,
        text: widget.buttonName,
        onPressed: addNewMeeting,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
        child: Column(
          children: [
            //header with title
            Header(title: widget.title),

            //search bar textfield
            MySearchBar(
              text: widget.searchText,
              onChanged: (value) => searchMeeting(value),
            ),

            // list of users
            Expanded(
                child: ListView.builder(
                    itemCount: _foundUser.length,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: GestureDetector(
                            onTap: () {
                              selectedMeeting(index);
                            },
                            child: MyMeetingTile(
                              meeting: _foundUser[index],
                            ),
                          ),
                        ))),
          ],
        ),
      ),
    );
  }
}
