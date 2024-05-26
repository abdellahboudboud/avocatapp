import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final String text;
  final IconData iconData;
  const MyCard({
    super.key,
    required this.text,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(14)),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Icon(
            iconData,
            size: 42,
            color: Theme.of(context).colorScheme.primary,
          ),
          Text(text,
              style: TextStyle(
                  fontFamily: 'Arabic',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary)),
        ],
      ),
    );
  }
}
