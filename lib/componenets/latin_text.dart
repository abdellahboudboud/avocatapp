import 'package:flutter/material.dart';

class Latintext extends StatelessWidget {
  final String text;
  const Latintext({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          fontFamily: 'Arabic',
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).colorScheme.primary,
        ));
  }
}
