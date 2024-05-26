// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:avocatapp/Models/images.dart';
import 'package:avocatapp/Models/videos.dart';
import 'package:avocatapp/componenets/button_icon.dart';
import 'package:avocatapp/componenets/header.dart';
import 'package:avocatapp/componenets/mytitle.dart';
import 'package:avocatapp/database/clients_images_db.dart';
import 'package:avocatapp/database/clients_videos_db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:open_file/open_file.dart';

class GalleryVideos extends StatefulWidget {
  int userid;
  GalleryVideos({super.key, required this.userid});

  @override
  State<GalleryVideos> createState() => _GalleryVideosState();
}

class _GalleryVideosState extends State<GalleryVideos> {
  // main code
  final videosClientsBox = Hive.box('videosClientsBox');
  ClientsVideosDB db = ClientsVideosDB();

  List<Videos> videosList = [];

  List selectedImages = [];

  bool multiselectionMode = false;

  // get images by userid from database
  @override
  void initState() {
    db.loadData();
    videosList =
        db.videosList.where((video) => video.userID == widget.userid).toList();

    //initilaize check boxes
    for (int i = 0; i < videosList.length; i++) {
      selectedImages.add([videosList[i].videoID, false]);
    }
    // TODO: implement initState
    super.initState();
  }

// upload image to database
  File? _selectedVideo;
  getVideoFromGallery() async {
    setState(() {
      multiselectionMode = false;
      for (int i = 0; i < selectedImages.length; i++) {
        selectedImages[i][1] = false;
      }
    });

    final returnedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (returnedVideo != null) {
      setState(() {
        _selectedVideo = File(returnedVideo.path);
        saveNewVideo(returnedVideo.path, returnedVideo.name);
        //print(returnedImage.path);
      });
    }
  }

// save image in database
  saveNewVideo(String filePath, String videoName) {
    setState(() {
      db.videosList.add(Videos(
          videoID: db.videosList.isEmpty ? 0 : db.videosList.last.videoID + 1,
          bloc: false,
          videoName: videoName,
          userID: widget.userid,
          videoPath: filePath));
      db.updateDatabase();
      loadVideosByUser();
    });
  }

  // delete image from database and update the UI
  deleteImageFromGallery(int videoID) {
    setState(() {
      db.videosList.removeWhere((element) => element.videoID == videoID);
      db.updateDatabase();
      loadVideosByUser();
    });
  }

  // share video file
  openVideo(String videoPath) async {
    // final result =
    //     await Share.shareXFiles([XFile('${videoPath}')], text: 'test video');

    // if (result.status == ShareResultStatus.success) {
    //   print('Thank you for sharing the video!');
    // }

    OpenFile.open(videoPath);
  }

  // load images by user
  loadVideosByUser() {
    videosList =
        db.videosList.where((video) => video.userID == widget.userid).toList();
    selectedImages = [];
    for (int i = 0; i < videosList.length; i++) {
      selectedImages.add([videosList[i].videoID, false]);
    }
  }

  // checkbox click
  checkboxChanged(bool? value, int index) {
    setState(() {
      selectedImages[index][1] = !selectedImages[index][1];
    });
  }

  // multiselection mode activated
  activateMultiselectionMode() {
    setState(() {
      if (multiselectionMode) {
        for (int i = 0; i < selectedImages.length; i++) {
          selectedImages[i][1] = false;
        }
      } else {
        multiselectionMode = true;
      }
    });
  }

  // delete Selected Images
  deleteSelectedImages() {
    setState(() {
      bool j = false;
      for (int i = 0; i < selectedImages.length; i++) {
        if (selectedImages[i][1]) {
          db.videosList.removeWhere(
              (element) => element.videoID == selectedImages[i][0]);
          j = true;
        }
      }
      if (j) {
        db.updateDatabase();
        loadVideosByUser();
        activateMultiselectionMode();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: getVideoFromGallery,
        label: Text(
          "إضافة فيديو",
          style: TextStyle(
            fontFamily: 'Arabic',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        icon: Icon(
          Icons.video_collection,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
        child: Column(
          children: [
            //header with title
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              height: 70,
              decoration: BoxDecoration(color: Colors.transparent),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyIconButton(
                    iconData: Icons.arrow_back_ios_new,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  MyTitle(title: "مقاطع الفيديو"),
                  MyIconButton(
                    iconData: Icons.delete,
                    onTap: deleteSelectedImages,
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: videosList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onLongPress: () {
                        activateMultiselectionMode();
                      },
                      onTap: () {
                        setState(() {
                          multiselectionMode = false;
                          for (int i = 0; i < selectedImages.length; i++) {
                            selectedImages[i][1] = false;
                          }
                        });
                        // deleteImageFromGallery(imagesList[index].imageID);
                        openVideo(videosList[index].videoPath);
                      },
                      child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Theme.of(context).colorScheme.secondary),
                          child: Stack(alignment: Alignment.center, children: [
                            Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.videocam,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    size: 72,
                                  ),
                                  Text(
                                    videosList[index].videoName,
                                    style: TextStyle(fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Visibility(
                                  visible: multiselectionMode,
                                  child: Checkbox(
                                    activeColor: Colors.white,
                                    checkColor: Colors.black,
                                    value: selectedImages[index][1],
                                    onChanged: (value) =>
                                        checkboxChanged(value, index),
                                  )),
                            )
                          ])));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
