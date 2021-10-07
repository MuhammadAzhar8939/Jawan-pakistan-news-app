// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class Profile extends StatelessWidget {
  late final Map data;
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  Profile({required this.data});
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
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(data["name"]),
            SizedBox(
              height: 20,
            ),
            Text(data["about"]),
            SizedBox(
              height: 20,
            ),
            Text(data["email"]),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
