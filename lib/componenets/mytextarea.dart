// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyTextArea extends StatelessWidget {
  String text;
  TextEditingController controller;
  MyTextArea({super.key, required this.text, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Theme.of(context).colorScheme.secondary),
      child: TextField(
          controller: controller,
          maxLines: 10,
          textAlign: TextAlign.end,
          style: TextStyle(
              fontFamily: 'Arabic', fontSize: 16, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
              border: InputBorder.none,
              disabledBorder: null,
              hintText: text,
              hintStyle: TextStyle(
                fontFamily: 'Arabic',
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ))),
    );
  }
}
