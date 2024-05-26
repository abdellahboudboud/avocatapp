// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'package:avocatapp/Models/user.dart';
import 'package:avocatapp/componenets/header.dart';
import 'package:avocatapp/componenets/myflaoting_button.dart';
import 'package:avocatapp/componenets/searchbar.dart';
import 'package:avocatapp/componenets/user_tile.dart';
import 'package:avocatapp/database/clients_list_db.dart';
import 'package:avocatapp/pages/add_client_page.dart';
import 'package:avocatapp/pages/client_profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';

class ClientsPage extends StatefulWidget {
  ClientsListDB db = ClientsListDB();
  String typeUser;
  String title;
  String buttonName;
  IconData buttonIcon;
  String searchText;
  String? job;
  ClientsPage(
      {super.key,
      required this.db,
      required this.typeUser,
      required this.title,
      required this.buttonName,
      required this.buttonIcon,
      required this.searchText,
      this.job});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  ClientsListDB db = ClientsListDB();
  List<User> originalUsers = [];
  List<User> _foundUser = [];

  @override
  void initState() {
    db = widget.db;
    originalUsers =
        db.ClientsList.where((user) => user.typeUser == widget.typeUser)
            .toList();

    _foundUser = originalUsers;

    // TODO: implement initState
    super.initState();
  }

  // add new user to list of users
  void addNewUser() async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddClientPage(
            typeUser: widget.typeUser,
            buttonName: widget.buttonName,
            buttonIcon: widget.buttonIcon,
            job: widget.job,
          ),
        )).then((value) => setState(() {
          db.loadData();
          originalUsers =
              db.ClientsList.where((user) => user.typeUser == widget.typeUser)
                  .toList();
          _foundUser = originalUsers;
        }));

    // if (result != null) {
    //   if (bool.parse(result)) {
    //     setState(() {
    //       db.loadData();
    //       originalUsers =
    //           db.ClientsList.where((user) => user.typeUser == widget.typeUser)
    //               .toList();
    //       _foundUser = originalUsers;
    //       print("***************************************************");
    //       print(" refresh is happened ");
    //       print("***************************************************");
    //     });
    //   }
    // }
    // _foundUser.add(User(
    //     UserID: 1,
    //     firstname: "test",
    //     lastname: "test",
    //     email: "test@gmail.com",
    //     telephone: "06xxxxxxxx",
    //     note: "...",
    //     profession: "test job",
    //     profileImagePath: "lib/images/benyahyati.png",
    //     ville: "الرباط",
    //     bloc: false));
    // db.ClientsList = _foundUser;
    // db.updateDatabase();
    // db.loadData();
  }

  // search for user returns list of users
  void searchUsers(String text) {
    List<User> result;
    if (text.isEmpty) {
      result = originalUsers;
    } else {
      // result =
      result =
          originalUsers.where((user) => user.fullname.contains(text)).toList();
      // print("hello : " + originalUsers[0].fullname);

      // db.ClientsList.where((user) => user.fullname.contains(text)).toList();
    }

    setState(() {
      _foundUser = result;
    });
  }

  // navigate to user profile page
  void selectedUser(int index) {
    Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ClientProfile(user: _foundUser[index])))
        .then((value) => setState(() {
              db.loadData();
              originalUsers = db.ClientsList.where(
                  (user) => user.typeUser == widget.typeUser).toList();
              _foundUser = originalUsers;
            }));
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: MyfloatingButton(
        iconData: widget.buttonIcon,
        text: widget.buttonName,
        onPressed: addNewUser,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
        child: Column(
          children: [
            //header with title
            Header(title: widget.title),

            //search bar textfield
            MySearchBar(
              text: widget.searchText,
              onChanged: (value) => searchUsers(value),
            ),

            // list of users
            Expanded(
                child: ListView.builder(
                    itemCount: _foundUser.length,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: GestureDetector(
                            onTap: () {
                              selectedUser(index);
                            },
                            child: MyUserTile(
                              user: _foundUser[index],
                            ),
                          ),
                        ))),
          ],
        ),
      ),
    );
  }
}
