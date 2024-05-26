// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:avocatapp/Models/user.dart';
import 'package:avocatapp/componenets/normal_text.dart';
import 'package:avocatapp/componenets/small_icon.dart';
import 'package:avocatapp/componenets/sub_text.dart';
import 'package:avocatapp/pages/clients_page.dart';
import 'package:flutter/material.dart';

class MyUserTile extends StatelessWidget {
  final User user;
  const MyUserTile({super.key, required this.user});

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
                    MyNormalText(text: user.fullname),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MySubText(text: user.ville),
                        SizedBox(width: 5),
                        MySmallIcon(iconData: Icons.location_on),
                        SizedBox(width: 5),
                        MySubText(text: user.profession),
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
                    borderRadius: BorderRadius.circular(14),
                    color: Theme.of(context).colorScheme.primaryContainer),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: user.profileImagePath.isNotEmpty
                        ? Image.file(
                            File(user.profileImagePath),
                            fit: BoxFit.cover,
                          )
                        : Container(
                            height: 80,
                            width: 80,
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                          )),
              ),
            ],
          ),
        ));
  }
}
