import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:news_app/category.dart';
import 'package:news_app/favorite.dart';
import 'package:news_app/home.dart';
import 'package:news_app/login.dart';
import 'package:news_app/profile.dart';
import 'package:news_app/sign_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ignore: avoid_print

  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Container();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter News App',
            theme: ThemeData(
              primarySwatch: Colors.blueGrey,
            ),
            home: Home(),
            routes: {
              "/Home": (context) => Home(),
              "/Login": (context) => Login(),
              "/SignUp": (context) => SignUp(),
              "/category": (context) => CategoryNewsSection(
                    categoryy: "general",
                  ),
              "/Favorite": (context) => Favorite(),
              "/profile": (context) => Profile(),
            },
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container();
      },
    );
  }
}
