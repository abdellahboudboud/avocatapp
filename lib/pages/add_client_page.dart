// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:avocatapp/Models/user.dart';
import 'package:avocatapp/componenets/header.dart';
import 'package:avocatapp/componenets/mybutton.dart';
import 'package:avocatapp/componenets/myimageprofile.dart';
import 'package:avocatapp/componenets/mytextbox.dart';
import 'package:avocatapp/database/clients_list_db.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddClientPage extends StatefulWidget {
  String typeUser;
  // String? title;
  String buttonName;
  IconData buttonIcon;
  User? user;
  String? job;
  AddClientPage(
      {super.key,
      required this.typeUser,
      required this.buttonName,
      required this.buttonIcon,
      this.job,
      this.user});

  @override
  State<AddClientPage> createState() => _AddClientPageState();
}

class _AddClientPageState extends State<AddClientPage> {
  // editing text controllers
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController telephone2Controller = TextEditingController();
  TextEditingController telephone3Controller = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController villeController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  String pickedImage = "";

  @override
  void initState() {
    if (widget.user != null) {
      firstNameController.text = widget.user!.firstname;
      lastNameController.text = widget.user!.lastname;
      emailController.text =
          widget.user!.email == null ? "" : widget.user!.email;
      telephoneController.text =
          widget.user!.telephone == null ? "" : widget.user!.telephone;
      telephone2Controller.text =
          widget.user!.telephone2 == null ? "" : widget.user!.telephone2!;
      telephone3Controller.text =
          widget.user!.telephone3 == null ? "" : widget.user!.telephone3!;
      professionController.text = widget.user!.profession;
      villeController.text = widget.user!.ville;
      noteController.text = widget.user!.note;
      pickedImage = widget.user!.profileImagePath;
    } else {
      professionController.text = widget.job!;
      pickedImage = "";
    }

// dont touch this state
    super.initState();
  }

// pick image from gallery
// upload image to database
  File? _selectedImage;
  getImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage != null) {
      setState(() {
        _selectedImage = File(returnedImage.path);
        pickedImage = returnedImage.path;
        //print(returnedImage.path);
      });
    }
  }

// add new user to the database check the code if client or lawyer
  addNewClient() {
    if (firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty) {
      ClientsListDB db = new ClientsListDB();
      db.loadData();
      if (widget.user == null) {
        User user = User(
            UserID: db.ClientsList.isEmpty ? 0 : db.ClientsList.last.UserID + 1,
            firstname: firstNameController.text,
            lastname: lastNameController.text,
            email: emailController.text.isEmpty ? "" : emailController.text,
            telephone: telephoneController.text.isEmpty
                ? ""
                : telephoneController.text,
            telephone2: telephone2Controller.text.isEmpty
                ? ""
                : telephone2Controller.text,
            telephone3: telephone3Controller.text.isEmpty
                ? ""
                : telephone3Controller.text,
            note: noteController.text.isEmpty ? "" : noteController.text,
            profession: professionController.text.isEmpty
                ? ""
                : professionController.text,
            profileImagePath: pickedImage,
            ville: villeController.text.isEmpty ? "" : villeController.text,
            bloc: false,
            typeUser: widget.typeUser.toString());
        db.ClientsList.add(user);

        db.updateDatabase();

        Navigator.pop(context, true);
      } else {
        widget.user!.firstname = firstNameController.text;
        widget.user!.lastname = lastNameController.text;
        widget.user!.email = emailController.text;
        widget.user!.telephone = telephoneController.text;
        widget.user!.telephone2 = telephone2Controller.text;
        widget.user!.telephone3 = telephone3Controller.text;
        widget.user!.note = noteController.text;
        widget.user!.profession = professionController.text;
        widget.user!.ville = villeController.text;
        widget.user!.profileImagePath = pickedImage;

        for (int i = 0; i < db.ClientsList.length; i++) {
          if (db.ClientsList[i].UserID == widget.user!.UserID) {
            db.ClientsList[i].firstname = widget.user!.firstname;
            db.ClientsList[i].lastname = widget.user!.lastname;
            db.ClientsList[i].email = widget.user!.email;
            db.ClientsList[i].telephone = widget.user!.telephone;
            db.ClientsList[i].telephone2 = widget.user!.telephone2!;
            db.ClientsList[i].telephone3 = widget.user!.telephone3!;
            db.ClientsList[i].note = widget.user!.note;
            db.ClientsList[i].profession = widget.user!.profession;
            db.ClientsList[i].ville = widget.user!.ville;
            db.ClientsList[i].profileImagePath = widget.user!.profileImagePath;
            db.ClientsList[i].updateFullName();
            break;
          }
        }

        db.updateDatabase();
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding:
              const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
          child: SingleChildScrollView(
            child: Column(children: [
              //header with title
              Header(title: widget.buttonName),
              Column(
                children: [
                  MyImageProfile(
                    imagePath: (pickedImage.isNotEmpty) ? pickedImage : "",
                    onPressed: getImageFromGallery,
                  ),
                  MyTextBox(
                    text: "الإسم الشخصي",
                    controller: firstNameController,
                  ),
                  MyTextBox(
                      text: "الإسم العائلــي", controller: lastNameController),
                  MyTextBox(
                      text: "البـريد الإلكترونــي",
                      controller: emailController),
                  MyTextBox(
                    text: "الهــاتف",
                    controller: telephoneController,
                  ),
                  MyTextBox(
                    text: "2 الهــاتف",
                    controller: telephone2Controller,
                  ),
                  MyTextBox(
                    text: "3 الهــاتف",
                    controller: telephone3Controller,
                  ),
                  MyTextBox(
                    text: "المهنــة",
                    controller: professionController,
                  ),
                  MyTextBox(
                    text: "المدينــة",
                    controller: villeController,
                  ),
                  MyTextBox(
                    text: "مـلاحظــة",
                    controller: noteController,
                  ),
                  MyButton(
                    text: widget.buttonName,
                    icon: widget.buttonIcon,
                    onPressed: addNewClient,
                  ),
                ],
              )
            ]),
          ),
        ));
  }
}
