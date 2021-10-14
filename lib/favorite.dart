import 'package:flutter/material.dart';
import 'package:news_app/home.dart';

// ignore: use_key_in_widget_constructors
class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
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
        // ignore: avoid_unnecessary_containers, prefer_const_constructors
        body: Container(
          child: dataa.isEmpty
              // ignore: avoid_unnecessary_containers, prefer_const_constructors
              ? Center(
                  // ignore: prefer_const_constructors
                  child: AlertDialog(
                    // ignore: prefer_const_constructors
                    title: Text(
                        "No News Available at this Time Kindly wait a second or try other category THANK YOU!"),
                  ),
                )
              : ListView.builder(
                  itemCount: dataa.length,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return BlogTile(
                        dataa[index].urlToImage as String,
                        dataa[index].title as String,
                        dataa[index].description as String,
                        dataa[index].url as String);
                  },
                ),
        ));
  }
}
