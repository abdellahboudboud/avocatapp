import 'package:flutter/material.dart';

class MySmallIcon extends StatelessWidget {
  final IconData iconData;
  const MySmallIcon({super.key, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Icon(
      iconData,
      size: 20,
      color: Theme.of(context).colorScheme.primaryContainer,
    );
  }
}
