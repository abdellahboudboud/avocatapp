// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:avocatapp/Models/meetings.dart';
import 'package:avocatapp/Models/user.dart';
import 'package:avocatapp/componenets/header.dart';
import 'package:avocatapp/componenets/mybutton.dart';
import 'package:avocatapp/componenets/myimageprofile.dart';
import 'package:avocatapp/componenets/mytextbox.dart';
import 'package:avocatapp/database/clients_list_db.dart';
import 'package:avocatapp/database/meetings_list_db.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddMeetingPage extends StatefulWidget {
  String typeUser;
  // String? title;
  String buttonName;
  IconData buttonIcon;
  Meetings? meet;
  String? job;
  AddMeetingPage(
      {super.key,
      required this.typeUser,
      required this.buttonName,
      required this.buttonIcon,
      this.job,
      this.meet});

  @override
  State<AddMeetingPage> createState() => _AddMeetingPageState();
}

class _AddMeetingPageState extends State<AddMeetingPage> {
  // editing text controllers
  TextEditingController MeetingNameController = TextEditingController();
  TextEditingController TitleController = TextEditingController();
  TextEditingController LocationController = TextEditingController();
  TextEditingController dateMeetingController = TextEditingController();


  @override
  void initState() {
    if (widget.meet != null) {
      MeetingNameController.text = widget.meet!.MeetingName;
      TitleController.text = widget.meet!.Title;
      LocationController.text = widget.meet!.Location;
      dateMeetingController.text = widget.meet!.dateMeeting;
    }

// dont touch this state
    super.initState();
  }


// add new user to the database check the code if client or lawyer
  addNewMeeting() async {
    if (MeetingNameController.text.isNotEmpty &&
        TitleController.text.isNotEmpty) {
      MeetingsListDB db = new MeetingsListDB();
      db.loadData();
      if (widget.meet == null) {
        Meetings meet = Meetings(
            MeetingID: db.MeetingsList.isEmpty ? 0 : db.MeetingsList.last.MeetingID + 1,
            MeetingName: MeetingNameController.text,
            Title: TitleController.text,
            Location: LocationController.text.isEmpty ? "" : LocationController.text,
            dateMeeting: dateMeetingController.text.isEmpty
                ? ""
                : dateMeetingController.text,
            
            bloc: false,
        );
        db.MeetingsList.add(meet);

        db.updateDatabase();

        Navigator.pop(context, true);
      } else {
        widget.meet!.MeetingName = MeetingNameController.text;
        widget.meet!.Title = TitleController.text;
        widget.meet!.Location = LocationController.text;
        widget.meet!.dateMeeting = dateMeetingController.text;
        

        for (int i = 0; i < db.MeetingsList.length; i++) {
          if (db.MeetingsList[i].MeetingID == widget.meet!.MeetingID) {
            db.MeetingsList[i].MeetingName = widget.meet!.MeetingName;
            db.MeetingsList[i].Title = widget.meet!.Title;
            db.MeetingsList[i].Location = widget.meet!.Location;
            db.MeetingsList[i].dateMeeting = widget.meet!.dateMeeting;
            break;
          }
        }

        db.updateDatabase();
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding:
              const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
          child: SingleChildScrollView(
            child: Column(children: [
              //header with title
              Header(title: widget.buttonName),
              Column(
                children: [
                  MyTextBox(
                    text: "إسم المحكمة",
                    controller: MeetingNameController,
                  ),
                  MyTextBox(
                      text: "عنوان الجلسة", controller: TitleController),
                  MyTextBox(
                      text: "المدينة",
                      controller: LocationController),
                  MyTextBox(
                    text: "تاريخ الجلسة",
                    controller: dateMeetingController,
                  ),
                  MyButton(
                    text: widget.buttonName,
                    icon: widget.buttonIcon,
                    onPressed: addNewMeeting,
                  ),
                ],
              )
            ]),
          ),
        ));
  }
}
