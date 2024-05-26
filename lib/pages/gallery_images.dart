// ignore_for_file: prefer_const_constructors

import 'dart:collection';
import 'dart:io';

import 'package:avocatapp/Models/images.dart';
import 'package:avocatapp/componenets/button_icon.dart';
import 'package:avocatapp/componenets/header.dart';
import 'package:avocatapp/componenets/mytitle.dart';
import 'package:avocatapp/database/clients_images_db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';

class GalleryImages extends StatefulWidget {
  int userid;
  GalleryImages({super.key, required this.userid});

  @override
  State<GalleryImages> createState() => _GalleryImagesState();
}

class _GalleryImagesState extends State<GalleryImages> {
  // main code
  final imageslistBox = Hive.box('imagesClientsBox');
  ClientsImagesDB db = ClientsImagesDB();

  List<Images> imagesList = [];

  List selectedImages = [];

  bool multiselectionMode = false;

  // get images by userid from database
  @override
  void initState() {
    db.loadData();
    imagesList =
        db.imagesList.where((image) => image.userID == widget.userid).toList();

    //initilaize check boxes
    for (int i = 0; i < imagesList.length; i++) {
      selectedImages.add([imagesList[i].imageID, false]);
    }
    // TODO: implement initState
    super.initState();
  }

// upload image to database
  File? imageInFile;
  getImageFromGallery() async {
    setState(() {
      multiselectionMode = false;
      for (int i = 0; i < selectedImages.length; i++) {
        selectedImages[i][1] = false;
      }
    });

    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage != null) {
      setState(() {
        imageInFile = File(returnedImage.path);
        saveNewImage(returnedImage.path);
        //print(returnedImage.path);
      });
    }
  }

// save image in database
  saveNewImage(String filePath) {
    setState(() {
      db.imagesList.add(Images(
          imageID: db.imagesList.isEmpty ? 0 : db.imagesList.last.imageID + 1,
          bloc: false,
          imageName: "photo" + DateTime.now().toString(),
          userID: widget.userid,
          ImagePath: filePath));
      db.updateDatabase();
      loadImagesByUser();
      //initilaize check boxes
    });
  }

  // delete image from database and update the UI
  deleteImageFromGallery(int imageID) {
    setState(() {
      db.imagesList.removeWhere((element) => element.imageID == imageID);
      db.updateDatabase();
      loadImagesByUser();
    });
  }

// share video file
  openImage(String imagePath) async {
    // final result =
    //     await Share.shareXFiles([XFile('${videoPath}')], text: 'test video');

    // if (result.status == ShareResultStatus.success) {
    //   print('Thank you for sharing the video!');
    // }

    OpenFile.open(imagePath);
  }

  // load images by user
  loadImagesByUser() {
    imagesList =
        db.imagesList.where((image) => image.userID == widget.userid).toList();
    selectedImages = [];
    for (int i = 0; i < imagesList.length; i++) {
      selectedImages.add([imagesList[i].imageID, false]);
    }
  }

  // select multiple items on gridview and remove them
  HashSet selectedItems = HashSet();

  doMultiselection(int id) {
    setState(() {
      if (selectedItems.contains(id)) {
        selectedItems.remove(id);
      } else {
        selectedItems.add(id);
      }
    });
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
          db.imagesList.removeWhere(
              (element) => element.imageID == selectedImages[i][0]);
          j = true;
        }
      }
      if (j) {
        db.updateDatabase();
        loadImagesByUser();
        activateMultiselectionMode();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: getImageFromGallery,
        label: Text(
          "إضافة صورة",
          style: TextStyle(
            fontFamily: 'Arabic',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        icon: Icon(
          Icons.add_a_photo,
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
            // header section
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
                  MyTitle(title: "الصـور"),
                  MyIconButton(
                    iconData: Icons.delete,
                    onTap: deleteSelectedImages,
                  ),
                ],
              ),
            ),

            // body text
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: imagesList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () {
                      activateMultiselectionMode();
                    },
                    onTap: () {
                      // deleteImageFromGallery(imagesList[index].imageID);
                      setState(() {
                        multiselectionMode = false;
                        for (int i = 0; i < selectedImages.length; i++) {
                          selectedImages[i][1] = false;
                        }
                      });
                      openImage(imagesList[index].ImagePath);
                    },
                    child: Container(
                      margin: EdgeInsets.all(1),
                      decoration: BoxDecoration(color: Colors.black),
                      child: Stack(alignment: Alignment.center, children: [
                        Container(
                            child: Image.file(File(imagesList[index].ImagePath),
                                fit: BoxFit.contain)),
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
                      ]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
