// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:ffi';

import 'package:avocatapp/componenets/button_yes_no.dart';
import 'package:avocatapp/componenets/normal_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DialogBox extends StatelessWidget {
  VoidCallback onYes;
  VoidCallback onNo;
  DialogBox({super.key, required this.onNo, required this.onYes});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 200,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(14)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DefaultTextStyle(
              style: TextStyle(
                  fontFamily: 'Arabic',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary),
              child: Text(
                "هل أنت متأكد أنك تريد إزالة هذا المستخدم من التطبيق بصفة نهائية",
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyChoiceButton(text: "لا", onPressed: onNo),
                SizedBox(
                  width: 15,
                ),
                MyChoiceButton(text: "نعم", onPressed: onYes),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
