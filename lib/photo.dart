import 'package:flutter/material.dart';

class Photo extends StatefulWidget {
  final String url;
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  Photo({required this.url});
  @override
  _PhotoState createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
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
      // ignore: avoid_unnecessary_containers
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.url),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
