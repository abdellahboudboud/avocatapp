// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:avocatapp/componenets/button_icon.dart';
import 'package:avocatapp/componenets/dialogbox.dart';
import 'package:avocatapp/componenets/mytitle.dart';
import 'package:avocatapp/database/clients_list_db.dart';
import 'package:flutter/material.dart';

class Header2Button extends StatelessWidget {
  final String title;
  Function(String)? onSelected;
  final int userID;
  Header2Button({super.key, required this.title, required this.userID});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          MyTitle(title: title),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.all(Radius.circular(14))),
            child: PopupMenuButton(
              onSelected: (value) {
                if (value == 0) {
                  // code edit user
                } else if (value == 1) {
                  // code delete user

                  // showDialog(
                  //   context: context,
                  //   builder: (context) {
                  //     return DialogBox();
                  //   },
                  // );

                  // ClientsListDB db = ClientsListDB();
                  // db.loadData();
                  // db.ClientsList.removeWhere(
                  //     (element) => element.UserID == userID);
                  // db.updateDatabase();
                  // Navigator.pop(context);
                }
              },
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
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      SizedBox(
                        width: 10,
                        height: 10,
                      ),
                      Icon(Icons.edit,
                          size: 24,
                          color: Theme.of(context).colorScheme.primary),
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
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      SizedBox(
                        width: 10,
                        height: 10,
                      ),
                      Icon(Icons.delete,
                          size: 24,
                          color: Theme.of(context).colorScheme.primary),
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
    );
  }
}
