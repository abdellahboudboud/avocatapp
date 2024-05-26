// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyImageProfile extends StatelessWidget {
  String imagePath;
  Function()? onPressed;
  MyImageProfile({super.key, required this.imagePath, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 200,
          height: 200,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(File(imagePath)),
              ),
              color: Theme.of(context).colorScheme.secondary,
              shape: BoxShape.circle),
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                alignment: Alignment.center,
                backgroundColor: Theme.of(context).colorScheme.secondary),
            child: Container(
              width: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("إضافة صورة",
                      style: TextStyle(
                          fontFamily: 'Arabic',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color:
                              Theme.of(context).colorScheme.primaryContainer)),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.add_a_photo,
                    size: 20,
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
