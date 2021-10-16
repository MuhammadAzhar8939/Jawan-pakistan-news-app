// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/login.dart';
import 'package:news_app/photo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// ignore: prefer_typing_uninitialized_variables

// ignore: use_key_in_widget_constructors, must_be_immutable
class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    userr();
  }

// ignore: non_constant_identifier_names
  void userr() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentSnapshot snapshot =
          await firestore.collection("users").doc(user.uid).get();
      final data = snapshot.data();

      // ignore: avoid_print
      print(data);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Bmw(
            data: data as Map,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Jawan Pakistan ",
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        elevation: 0.0,
      ),
      body: Container(
        child: Center(
            child: Text("wait a second\nclick back button to goto home page")),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors, must_be_immutable
class Bmw extends StatefulWidget {
  Map data;
  // ignore: use_key_in_widget_constructors
  Bmw({required this.data});

  @override
  _BmwState createState() => _BmwState();
}

class _BmwState extends State<Bmw> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController aboutController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    XFile? image;
    // ignore: unused_local_variable
    String? imagePath;
    // ignore: unused_local_variable
    String? imageName;
    void done() async {
      try {
        FirebaseAuth auth = FirebaseAuth.instance;
        final user = auth.currentUser;
        String name = nameController.text;
        String about = aboutController.text;
        String email = emailController.text;
        String picName = imageName as String;
        String picPath = imagePath as String;
        firebase_storage.Reference ref =
            firebase_storage.FirebaseStorage.instance.ref(picName);

        File file = File(picPath);
        await ref.putFile(file);
        String downloadURL = await ref.getDownloadURL();
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        await firestore.collection("users").doc(user!.uid).set({
          "name": name,
          "about": about,
          "email": email,
          "picURL": downloadURL
        });
        Navigator.of(context).pop();
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    }

    void pickImage() async {
      final ImagePicker _picker = ImagePicker();
      // Pick an image
      image = await _picker.pickImage(source: ImageSource.gallery);
      imagePath = image?.path;
      imageName = image?.name;
      File file = File(imagePath as String);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Image.file(file),
                  ),
                  Text(imageName.toString()),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: "Full Name",
                    ),
                  ),
                  TextField(
                    controller: aboutController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: "About Your Self",
                    ),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      hintText: "Email",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: done,
                    icon: Icon(Icons.done),
                    label: Text("Done"),
                  )
                ],
              ),
            ),
          );
        },
      );
    }

    // ignore: non_constant_identifier_names

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Jawan Pakistan ",
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text("\nYou can edit profile by clicking camera icon"),
              SizedBox(
                height: 10,
              ),
              Center(
                child: SizedBox(
                  height: 150,
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return Photo(
                                url: widget.data["picURL"],
                              );
                            }),
                          );
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(widget.data["picURL"]),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 90,
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: FloatingActionButton(
                            onPressed: () {
                              pickImage();
                            },
                            child: Icon(
                              Icons.photo_camera,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 2), color: Colors.grey[200]),
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    widget.data["name"],
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 2), color: Colors.grey[200]),
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    widget.data["about"],
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 2), color: Colors.grey[200]),
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    widget.data["email"],
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: ElevatedButton.icon(
                    onPressed: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      await preferences.remove('email');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return Login();
                        }),
                      );
                    },
                    icon: Icon(Icons.logout),
                    label: Text("Logout")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
