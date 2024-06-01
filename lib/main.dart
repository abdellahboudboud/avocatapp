// ignore_for_file: prefer_const_constructors

import 'package:avocatapp/Models/files.dart';
import 'package:avocatapp/Models/images.dart';
import 'package:avocatapp/Models/meetings.dart';
import 'package:avocatapp/Models/videos.dart';
import 'package:avocatapp/pages/home_pages.dart';
import 'package:avocatapp/themes/light_theme.dart';
import 'package:avocatapp/Models/user.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(ImagesAdapter());
  Hive.registerAdapter(VideosAdapter());
  Hive.registerAdapter(FilesAdapter());
  Hive.registerAdapter(MeetingsAdapter());

  var clientlistBox = await Hive.openBox('listClientsBox');
  var imagesClientsBox = await Hive.openBox('imagesClientsBox');
  var videosClientsBox = await Hive.openBox('videosClientsBox');
  var filesClientsBox = await Hive.openBox('filesClientsBox');
  var MeetingsBox = await Hive.openBox('MeetingsBox');
  runApp(const MyApp());
  // initalize hive
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: Homepage(),
    );
  }
}
