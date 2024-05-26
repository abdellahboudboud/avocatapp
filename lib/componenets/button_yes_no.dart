// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyChoiceButton extends StatelessWidget {
  String text;
  VoidCallback onPressed;
  MyChoiceButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          textStyle: TextStyle(
              fontFamily: 'Arabic',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.primary)),
    );
  }
}
