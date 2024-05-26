// ignore_for_file: prefer_const_constructors

import 'package:avocatapp/componenets/button_icon.dart';
import 'package:avocatapp/componenets/mytitle.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  const Header({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      height: 70,
      decoration: BoxDecoration(color: Colors.transparent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyIconButton(
            iconData: Icons.arrow_back_ios_new,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          MyTitle(title: title),
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(color: Colors.transparent),
          )
        ],
      ),
    );
  }
}
