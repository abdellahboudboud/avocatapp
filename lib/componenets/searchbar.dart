// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  final String text;
  final Function(String)? onChanged;
  const MySearchBar({super.key, required this.text, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10)),
      child: TextField(
        onChanged: onChanged,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontFamily: 'Arabic',
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          disabledBorder: null,
          hintText: text,
          hintStyle: TextStyle(
            fontFamily: 'Arabic',
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
          fillColor: Colors.transparent,
          filled: true,
          icon: Icon(Icons.search),
          iconColor: Colors.black54,
        ),
      ),
    );
  }
}
