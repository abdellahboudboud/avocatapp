// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:avocatapp/Models/meetings.dart';
import 'package:avocatapp/Models/user.dart';
import 'package:avocatapp/componenets/normal_text.dart';
import 'package:avocatapp/componenets/small_icon.dart';
import 'package:avocatapp/componenets/sub_text.dart';
import 'package:avocatapp/pages/clients_page.dart';
import 'package:flutter/material.dart';

class MyMeetingTile extends StatelessWidget {
  final Meetings meeting;
  const MyMeetingTile({super.key, required this.meeting});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              SizedBox(
                child: MySmallIcon(
                  iconData: Icons.arrow_back_ios,
                ),
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    MyNormalText(text: meeting.Title),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MySubText(text: meeting.dateMeeting),
                        SizedBox(width: 5),
                        MySmallIcon(iconData: Icons.calendar_month),
                      ]
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MySubText(text: meeting.Location),
                        SizedBox(width: 5),
                        MySmallIcon(iconData: Icons.location_on),
                        SizedBox(width: 5),
                        MySubText(text: meeting.MeetingName),
                        SizedBox(width: 5),
                        MySmallIcon(
                          iconData: Icons.work,
                        ),
                      ],
                    )
                  ],
                ),
              )),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Icon(Icons.balance,size: 72,),)
              ),
            ],
          ),
        ));
  }
}
