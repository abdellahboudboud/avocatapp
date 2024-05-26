// ignore_for_file: prefer_const_constructors

import 'dart:collection';
import 'dart:io';

import 'package:avocatapp/Models/files.dart';
import 'package:avocatapp/Models/images.dart';
import 'package:avocatapp/Models/videos.dart';
import 'package:avocatapp/componenets/button_icon.dart';
import 'package:avocatapp/componenets/header.dart';
import 'package:avocatapp/componenets/mytitle.dart';
import 'package:avocatapp/database/clients_files_db.dart';
import 'package:avocatapp/database/clients_images_db.dart';
import 'package:avocatapp/database/clients_videos_db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:open_file/open_file.dart';
import 'package:file_picker/file_picker.dart';

class GalleryFiles extends StatefulWidget {
  int userid;
  GalleryFiles({super.key, required this.userid});

  @override
  State<GalleryFiles> createState() => _GalleryFilesState();
}

class _GalleryFilesState extends State<GalleryFiles> {
  // main code
  final filesClientsBox = Hive.box('filesClientsBox');
  ClientsFilesDB db = ClientsFilesDB();

  List<Files> filesList = [];

  List selectedImages = [];

  bool multiselectionMode = false;

  // get images by userid from database
  @override
  void initState() {
    db.loadData();
    filesList =
        db.filesList.where((file) => file.userID == widget.userid).toList();

    //initilaize check boxes
    for (int i = 0; i < filesList.length; i++) {
      selectedImages.add([filesList[i].fileID, false]);
    }
    // TODO: implement initState
    super.initState();
  }

// upload image to database
  // File? _selectedFiles;
  getFileFromGallery() async {
    setState(() {
      multiselectionMode = false;
      for (int i = 0; i < selectedImages.length; i++) {
        selectedImages[i][1] = false;
      }
    });

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      saveNewFile(file.path.toString(), file.name.toString());
    } else {
      // User canceled the picker
    }

    // FilePickerResult? result = await FilePicker.platform.pickFiles();

    // if (result != null) {
    //   print(result.files.single.path!);
    //   // saveNewFile(returnedFile.path);
    // } else {
    //   // User canceled the picker
    // }

    // if (returnedFile != null) {
    //   setState(() {
    //     _selectedFiles = File(returnedFile.path);
    //     saveNewFile(returnedFile.path);
    //     //print(returnedImage.path);
    //   });
    // }
  }

// save image in database
  saveNewFile(String filePath, String fileName) {
    if (filePath.isNotEmpty && fileName.isNotEmpty) {
      setState(() {
        db.filesList.add(Files(
            fileID: db.filesList.isEmpty ? 0 : db.filesList.last.fileID + 1,
            bloc: false,
            fileName: fileName,
            userID: widget.userid,
            filePath: filePath));
        db.updateDatabase();
        loadFilesByUser();
      });
    }
  }

  // delete image from database and update the UI
  deleteImageFromGallery(int fileID) {
    setState(() {
      db.filesList.removeWhere((element) => element.fileID == fileID);
      db.updateDatabase();
      loadFilesByUser();
    });
  }

  // share video file
  openFichier(String filePath) async {
    OpenFile.open(filePath);
  }

  // load images by user
  loadFilesByUser() {
    filesList =
        db.filesList.where((file) => file.userID == widget.userid).toList();

    selectedImages = [];
    for (int i = 0; i < filesList.length; i++) {
      selectedImages.add([filesList[i].fileID, false]);
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
          db.filesList
              .removeWhere((element) => element.fileID == selectedImages[i][0]);
          j = true;
        }
      }
      if (j) {
        db.updateDatabase();
        loadFilesByUser();
        activateMultiselectionMode();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: getFileFromGallery,
        label: Text(
          "إضافة ملـف",
          style: TextStyle(
            fontFamily: 'Arabic',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        icon: Icon(
          Icons.file_copy,
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
                  MyTitle(title: "الملفــات"),
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
                itemCount: filesList.length,
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
                        // deleteImageFromGallery(filesList[index].fileID);
                        openFichier(filesList[index].filePath);
                      },
                      child: Stack(alignment: Alignment.center, children: [
                        Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Theme.of(context).colorScheme.secondary),
                            child: Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.file_copy,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    size: 72,
                                  ),
                                  Text(
                                    filesList[index].fileName,
                                    style: TextStyle(fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )),
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
                      ]));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
