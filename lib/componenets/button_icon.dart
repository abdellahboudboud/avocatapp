// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final Function()? onTap;
  final IconData iconData;
  const MyIconButton({super.key, required this.onTap, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.all(Radius.circular(14))),
        child: Center(
            child: Icon(
          iconData,
          size: 24,
        )),
      ),
    );
  }
}
