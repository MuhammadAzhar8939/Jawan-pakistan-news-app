// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

bool loading = true;

// ignore: use_key_in_widget_constructors, must_be_immutable
class CategoryNewsSection extends StatefulWidget {
  late String categoryy;
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  CategoryNewsSection({required this.categoryy});
  @override
  _CategoryNewsSectionState createState() => _CategoryNewsSectionState();
}

class _CategoryNewsSectionState extends State<CategoryNewsSection> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    calling();
  }

  // ignore: use_key_in_widget_constructors

  void calling() async {
    // ignore: avoid_print
    print(widget.categoryy);
    await getNews(widget.categoryy);
    setState(() {
      loading = false;
    });
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
      // ignore: avoid_unnecessary_containers
      body: loading
          // ignore: avoid_unnecessary_containers
          ? Container(
              child: const Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              // ignore: avoid_unnecessary_containers
              child: Container(
                child: ListView.builder(
                    itemCount: articles.length,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return BlogTile(
                          articles[index].urlToImage,
                          articles[index].title,
                          articles[index].description,
                          articles[index].url);
                    }),
              ),
            ),
    );
  }
}

///////
class NewsApi {
  String title;
  String description;
  String url;
  String urlToImage;
  String content;

  NewsApi(
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.content,
  );
}

late List<NewsApi> articles = [];

Future<void> getNews(String categoryy) async {
  // ignore: avoid_print
  print(categoryy);
  try {
    String apikey =
        "https://newsapi.org/v2/top-headlines?category=$categoryy&apiKey=f76afcf58a4e42fea62d8eacc3cb0e5d";
    // String apikey =
    //     "https://newsapi.org/v2/top-headlines?category=$categoryy&country=us&apiKey=f24e415df31341a19f07541381594335";

    // ignore: avoid_print
    print(apikey);

    var response = await http.get(Uri.parse(apikey));
    var jsonData = await jsonDecode(response.body);
    if (jsonData["status"] == "ok") {
      await jsonData["articles"].forEach(
        (element) {
          if (element["urlToImage"] != null && element["description"] != null) {
            var article = NewsApi(
              element["title"],
              element["description"],
              element["url"],
              element["urlToImage"],
              element["content"],
            );
            articles.add(article);
          }
        },
      );
    }
  } on HttpException catch (e) {
    // ignore: avoid_print
    print(e.message);
    // print(apikey);
  }
}
