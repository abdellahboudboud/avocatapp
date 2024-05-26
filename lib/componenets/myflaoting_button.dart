// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyfloatingButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  void Function()? onPressed;
  MyfloatingButton(
      {super.key,
      required this.iconData,
      required this.text,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Theme.of(context).colorScheme.primary,
      onPressed: onPressed,
      label: Text(
        text,
        style: TextStyle(
          fontFamily: 'Arabic',
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).colorScheme.background,
        ),
      ),
      icon: Icon(
        iconData,
        size: 24,
        color: Theme.of(context).colorScheme.background,
      ),
      extendedPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    );
  }
}
