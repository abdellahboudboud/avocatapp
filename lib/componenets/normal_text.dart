import 'package:flutter/material.dart';

class MyNormalText extends StatelessWidget {
  final String text;
  const MyNormalText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Arabic',
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
