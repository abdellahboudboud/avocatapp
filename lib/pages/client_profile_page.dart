// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_if_null_operators

import 'dart:io';

import 'package:avocatapp/Models/user.dart';
import 'package:avocatapp/componenets/button_icon.dart';
import 'package:avocatapp/componenets/card_item.dart';
import 'package:avocatapp/componenets/client_profileItem.dart';
import 'package:avocatapp/componenets/dialogbox.dart';
import 'package:avocatapp/componenets/header_2buttons.dart';
import 'package:avocatapp/componenets/mytitle.dart';
import 'package:avocatapp/componenets/normal_text.dart';
import 'package:avocatapp/componenets/small_icon.dart';
import 'package:avocatapp/componenets/sub_text.dart';
import 'package:avocatapp/database/clients_files_db.dart';
import 'package:avocatapp/database/clients_images_db.dart';
import 'package:avocatapp/database/clients_list_db.dart';
import 'package:avocatapp/database/clients_videos_db.dart';
import 'package:avocatapp/pages/add_client_page.dart';
import 'package:avocatapp/pages/gallery_files.dart';
import 'package:avocatapp/pages/gallery_images.dart';
import 'package:avocatapp/pages/gallery_videos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'clients_page.dart';

class ClientProfile extends StatefulWidget {
  User user;
  ClientProfile({super.key, required this.user});

  @override
  State<ClientProfile> createState() => _ClientProfileState();
}

class _ClientProfileState extends State<ClientProfile> {
  @override
  Widget build(BuildContext context) {
    User user = widget.user;
    List items = [
      ["البريد الإلكترونــي", user.email.isNotEmpty ? user.email : ""],
      ["رقم الهاتف", user.telephone.isNotEmpty ? user.telephone : ""],
      ["1 رقم الهاتف", user.telephone2 != null ? user.telephone2 : ""],
      ["2 رقم الهاتف", user.telephone3 != null ? user.telephone3 : ""],
      ["ملاحظــة", user.note.isNotEmpty ? user.note : ""],
    ];
    List itemsMenu = [
      ["الصور", Icons.image],
      ["المقاطع", Icons.video_collection],
      ["الملفـات", Icons.file_copy],
    ];

    void selectedGallery(int index) {
      /* 
          0: imageGallery
          1: videosGallery
          2: filesGallery
      */
      if (index == 0) {
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GalleryImages(userid: user.UserID),
              ));
        });
      } else if (index == 1) {
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GalleryVideos(userid: user.UserID),
              ));
        });
      } else if (index == 2) {
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GalleryFiles(userid: user.UserID),
              ));
        });
      }
    }

    //selected poop up menu delelte ou modifier
    void selectedPopupMenu(int value) {
      if (value == 0) {
        // code edit user / show addnewUser page or create new page of edit user
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddClientPage(
                typeUser: "null",
                buttonName: "تعديل",
                buttonIcon: Icons.edit,
                user: user,
              ),
            )).then((value) => setState(() {
              ClientsListDB db = ClientsListDB();
              db.loadData();
              widget.user = db.ClientsList.where(
                  (element) => element.UserID == widget.user.UserID).single;
            }));
        ;
      } else if (value == 1) {
        // code delete user

        showDialog(
          context: context,
          builder: (context) {
            return DialogBox(
              onYes: () {
                ClientsVideosDB db_videos = ClientsVideosDB();
                ClientsFilesDB db_files = ClientsFilesDB();
                ClientsImagesDB db_images = ClientsImagesDB();
                ClientsListDB db = ClientsListDB();
                //delete videos by user
                db_videos.loadData();
                db_videos.videosList.removeWhere(
                    (element) => element.userID == widget.user.UserID);
                db_videos.updateDatabase();
                // delete files by user
                db_files.loadData();
                db_files.filesList.removeWhere(
                    (element) => element.userID == widget.user.UserID);
                db_files.updateDatabase();
                // delete images by user
                db_images.loadData();
                db_images.imagesList.removeWhere(
                    (element) => element.userID == widget.user.UserID);
                db_images.updateDatabase();
                // delete user from database
                db.loadData();
                db.ClientsList.removeWhere(
                    (element) => element.UserID == widget.user.UserID);
                db.updateDatabase();
                Navigator.pop(context);
                Navigator.pop(context);
              },
              onNo: () {
                Navigator.pop(context);
              },
            );
          },
        );
      }
    }

    return Scaffold(
        body: Padding(
            padding:
                const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
            child: Column(children: [
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
                    MyTitle(title: "الملف الشخصي"),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                      child: PopupMenuButton(
                        onSelected: (value) => selectedPopupMenu(value),
                        iconSize: 26,
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 0,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "تعديـل",
                                  style: TextStyle(
                                      fontFamily: 'Arabic',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                                SizedBox(
                                  width: 10,
                                  height: 10,
                                ),
                                Icon(Icons.edit,
                                    size: 24,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "مسح",
                                  style: TextStyle(
                                      fontFamily: 'Arabic',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                                SizedBox(
                                  width: 10,
                                  height: 10,
                                ),
                                Icon(Icons.delete,
                                    size: 24,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                    // MyIconButton(
                    //   iconData: Icons.more_vert,
                    //   onTap: () => onTap,
                    // ),
                  ],
                ),
              ),

              //show profile image,fullname,profession,ville
              Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  height: 150,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(14)),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                  child: Container(
                                      alignment: Alignment.centerRight,
                                      child:
                                          MyNormalText(text: user.fullname))),
                              Expanded(
                                  child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      MySubText(text: user.profession),
                                      SizedBox(width: 5),
                                      MySmallIcon(
                                        iconData: Icons.work,
                                      ),
                                    ],
                                  ),
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        MySubText(text: user.ville),
                                        SizedBox(width: 5),
                                        MySmallIcon(
                                            iconData: Icons.location_on),
                                      ])
                                ],
                              ))
                            ],
                          ),
                        )),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: user.profileImagePath.isNotEmpty
                                ? Image.file(
                                    File(user.profileImagePath),
                                    fit: BoxFit.cover,
                                  ) : Container(
                                    height: 130,
                                    width: 130,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  )),
              //show email,telephone,note,
              Expanded(
                flex: 3,
                child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: ((context, index) => GestureDetector(
                          onTap: () async {
                            // make a phone call to number directly
                            if (index == 0) {
                              String? encodeQueryParameters(
                                  Map<String, String> params) {
                                return params.entries
                                    .map((MapEntry<String, String> e) =>
                                        '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                    .join('&');
                              }

// ···
                              final Uri emailLaunchUri = Uri(
                                scheme: 'mailto',
                                path: items[index][1].toString(),
                                query: encodeQueryParameters(<String, String>{
                                  'subject': "",
                                  'body': ""
                                }),
                              );

                              try {
                                await launchUrl(emailLaunchUri);
                              } catch (e) {
                                print(e.toString());
                              }
                            }
                            if (index == 1) {
                              await FlutterPhoneDirectCaller.callNumber(
                                  items[index][1]);
                            } else if (index == 2) {
                              await FlutterPhoneDirectCaller.callNumber(
                                  items[index][1]);
                            } else if (index == 3) {
                              await FlutterPhoneDirectCaller.callNumber(
                                  items[index][1]);
                            }
                          },
                          child: MyProfileItem(
                              title: items[index][0], value: items[index][1]),
                        ))),
              ),

              //buttons for media / images,videos,files
              Expanded(
                flex: 1,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: itemsMenu.length,
                    itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            selectedGallery(index);
                          },
                          child: MyCard(
                            text: itemsMenu[index][0],
                            iconData: itemsMenu[index][1],
                          ),
                        )),
              ),
            ])));
  }
}
