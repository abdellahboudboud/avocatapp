import 'package:avocatapp/componenets/normal_text.dart';
import 'package:flutter/material.dart';

class MyProfileItem extends StatelessWidget {
  final String title;
  final String value;
  const MyProfileItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [MyNormalText(text: title), MyNormalText(text: value)],
      ),
    );
  }
}
