// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: use_key_in_widget_constructors
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    XFile? image;
    // ignore: unused_local_variable
    String? imagePath;
    // ignore: unused_local_variable
    String? imageName;

    final TextEditingController nameController = TextEditingController();
    final TextEditingController aboutController = TextEditingController();

    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    // ignore: non_constant_identifier_names
    void Register() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      String name = nameController.text;
      String about = aboutController.text;
      String email = emailController.text;
      String password = passwordController.text;
      try {
        final UserCredential user = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await firestore
            .collection("users")
            .doc(user.user!.uid)
            .set({"name": name, "about": about, "email": email});
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
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Image(
                    image: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZFZS5BnaNQwIJcppLTAuxL4nvTjen5Ce73w&usqp=CAU",
                    ),
                    width: 170,
                    height: 170,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(imageName.toString() + "\n\n is selected"),
              ],
            ),
          );
        },
      );
    }

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
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("To Add News in favorite Login/Signup First\n\n\n\n\n\n"),
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
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  icon: Icon(Icons.password),
                  hintText: "password",
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: pickImage,
                  child: Icon(
                    Icons.photo_camera,
                    size: 70,
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(onPressed: Register, child: Text("Sign Up")),
              Text("\nAlready Have An Account?\n"),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: Text("Login")),
            ],
          ),
        ),
      ),
    );
  }
}
