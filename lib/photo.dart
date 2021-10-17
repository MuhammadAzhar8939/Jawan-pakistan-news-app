import 'package:cached_network_image/cached_network_image.dart';
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
      // ignore: avoid_unnecessary_containers, sized_box_for_whitespace
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: CachedNetworkImage(
          imageUrl: widget.url,
          // ignore: prefer_const_constructors
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Image.network(
            "https://www.prestashop.com/sites/default/files/styles/blog_750x320/public/blog/2019/10/banner_error_404.jpg?itok=eAS4swln",
          ),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
