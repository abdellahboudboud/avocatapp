import 'package:flutter/material.dart';

class MySubText extends StatelessWidget {
  final String text;
  const MySubText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Arabic',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
    );
  }
}
