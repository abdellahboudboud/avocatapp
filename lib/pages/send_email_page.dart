// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'package:avocatapp/Models/user.dart';
import 'package:avocatapp/componenets/header.dart';
import 'package:avocatapp/componenets/mybutton.dart';
import 'package:avocatapp/componenets/mytextarea.dart';
import 'package:avocatapp/componenets/mytextbox.dart';
import 'package:avocatapp/database/clients_list_db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';

class SendEmailPage extends StatefulWidget {
  const SendEmailPage({super.key});

  @override
  State<SendEmailPage> createState() => _SendEmailPageState();
}

class _SendEmailPageState extends State<SendEmailPage> {
  TextEditingController objetController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  bool checkboxAvocatMaleEtat = false;

  checkboxAvocatMale() {
    setState(() {
      checkboxAvocatMaleEtat = !checkboxAvocatMaleEtat;
    });
  }

  bool checkboxAvocatFeMaleEtat = false;

  checkboxAvocatFeMale() {
    setState(() {
      checkboxAvocatFeMaleEtat = !checkboxAvocatFeMaleEtat;
    });
  }

  bool checkboxClientEtat = false;

  checkboxClient() {
    setState(() {
      checkboxClientEtat = !checkboxClientEtat;
    });
  }

  bool checkboxNakibEtat = false;

  checkboxNakib() {
    setState(() {
      checkboxNakibEtat = !checkboxNakibEtat;
    });
  }

  onPressedSendEmail() async {
    //code to send the email
    if (bodyController.text.isNotEmpty && objetController.text.isNotEmpty) {
      String emails = "";
      ClientsListDB db = ClientsListDB();
      db.loadData();

      if (checkboxClientEtat) {
        List<User> ClientsList =
            db.ClientsList.where((user) => user.typeUser == "0").toList();
        for (int i = 0; i < ClientsList.length; i++) {
          emails = emails + ClientsList[i].email + ",";
        }
      }

      if (checkboxAvocatMaleEtat) {
        List<User> AvocatMaleList =
            db.ClientsList.where((user) => user.typeUser == "1").toList();
        for (int i = 0; i < AvocatMaleList.length; i++) {
          emails = emails + AvocatMaleList[i].email + ",";
        }
      }

      if (checkboxAvocatFeMaleEtat) {
        List<User> AvocatFeMaleList =
            db.ClientsList.where((user) => user.typeUser == "2").toList();
        for (int i = 0; i < AvocatFeMaleList.length; i++) {
          emails = emails + AvocatFeMaleList[i].email + ",";
        }
      }

      if (checkboxNakibEtat) {
        List<User> NakibList =
            db.ClientsList.where((user) => user.typeUser == "4").toList();
        for (int i = 0; i < NakibList.length; i++) {
          emails = emails + NakibList[i].email + ",";
        }
      }

      // get list of all email selected clients or female avocat or male avocat

      // enter parameteres of email
      // print(emails);
      // send email code
      String? encodeQueryParameters(Map<String, String> params) {
        return params.entries
            .map((MapEntry<String, String> e) =>
                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
            .join('&');
      }

// ···
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: emails,
        query: encodeQueryParameters(<String, String>{
          'subject': objetController.text,
          'body': bodyController.text
        }),
      );

      try {
        launchUrl(emailLaunchUri);
      } catch (e) {
        print(e.toString());
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
              child: Column(
                children: [
                  //header with title
                  Header(title: "البريـد"),
                  MyTextBox(
                    text: "عنوان الموضوع",
                    controller: objetController,
                  ),
                  Container(
                    child: MyTextArea(
                      text: " ....أكتب الموضوع",
                      controller: bodyController,
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Theme.of(context).colorScheme.secondary),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "المرسل إليه",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontFamily: 'Arabic',
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Column(
                            children: [
                              // list of avocat male
                              Row(
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          "المحامون",
                                          style: TextStyle(
                                              fontFamily: 'Arabic',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Checkbox(
                                          value: checkboxAvocatMaleEtat,
                                          onChanged: (value) =>
                                              checkboxAvocatMale(),
                                        )
                                      ],
                                    ),
                                  ),

                                  // list of avocat female
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          "المحاميات",
                                          style: TextStyle(
                                              fontFamily: 'Arabic',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Checkbox(
                                          value: checkboxAvocatFeMaleEtat,
                                          onChanged: (value) =>
                                              checkboxAvocatFeMale(),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              // list of clients
                              Row(
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          "النقبــاء",
                                          style: TextStyle(
                                              fontFamily: 'Arabic',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Checkbox(
                                          value: checkboxNakibEtat,
                                          onChanged: (value) => checkboxNakib(),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          "الموكلون",
                                          style: TextStyle(
                                              fontFamily: 'Arabic',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Checkbox(
                                          value: checkboxClientEtat,
                                          onChanged: (value) =>
                                              checkboxClient(),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  MyButton(
                    text: "إرسال البريد",
                    icon: Icons.send,
                    onPressed: onPressedSendEmail,
                  ),
                ],
              ),
            )));
  }
}
