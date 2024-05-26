// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TestimenialItem extends StatelessWidget {
  final String name;
  final String imagePath;

  TestimenialItem({
    super.key,
    required this.name,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      height: 130,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 90,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(14)),
          ),
          Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 130,
                child: Image.asset(imagePath, fit: BoxFit.cover),
              )),
          Positioned(
              bottom: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(14)),
                    height: 90,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        name,
                        style: TextStyle(
                          fontFamily: 'Arabic',
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
