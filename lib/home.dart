// ignore_for_file: avoid_print, prefer_const_constructors, use_key_in_widget_constructors

import 'dart:async';
import 'dart:convert';
// ignore: unused_import
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/category.dart';
import 'package:news_app/favorite.dart';
import 'package:news_app/inappwebview.dart';
import 'package:news_app/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

bool loading = true;
String categoryyy = "business";
// ignore: prefer_typing_uninitialized_variables

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    calling();
  }

  void calling() async {
    await getNews(categoryyy);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //creating list of category
    List<CategoryModel> category = [];
    var categry = CategoryModel("business",
        "https://media.istockphoto.com/photos/business-development-to-success-and-growing-growth-concept-pointing-picture-id1145631842?k=20&m=1145631842&s=612x612&w=0&h=fkLeeD7b0fV5KJgDRuDOA3vmTyNB8n5f5gLlmk785OQ=");
    category.add(categry);
    categry = CategoryModel(
      "general",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVLnqTl99l_vI8wy5Mf1ODqDKiH2moQUTXRg&usqp=CAU",
    );
    category.add(categry);
    categry = CategoryModel("technology ",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDlbyO5cUawmv1jd60zD7AJqjET-dEx1Qabg5iE0jZxr5FTkJNwiidJZxFF0e1qfoUX40&usqp=CAU");
    category.add(categry);

    categry = CategoryModel("science",
        "https://image.shutterstock.com/image-photo/hands-touching-science-network-connection-260nw-762804589.jpg");
    category.add(categry);
    categry = CategoryModel("health ",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpDO8foZRhRl-AAK5vio7p_VBXTOrC_Xk1uSEnkDXHu7WFZeN97Ghk6JW0n7TioYnTP4o&usqp=CAU");
    category.add(categry);
    categry = CategoryModel("entertainment",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIub_BMYsKunj7yXl8mH41y3zbaXpMHoiMWc9un4cb6TX2kbOSg6vB9-dRtRPjyTsgwpU&usqp=CAU");
    category.add(categry);
    categry = CategoryModel("sports",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkgRobyLN82AlOxu2AvputX63kMGNnUo4hYw&usqp=CAU");
    category.add(categry);

//addition of all category done

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          BottomNavigationBarItem(
            icon: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ),
                  );
                },
                child: Icon(Icons.home_filled)),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Favorite(),
                    ),
                  );
                },
                child: Icon(Icons.favorite)),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile(),
                    ),
                  );
                },
                child: Icon(Icons.person)),
            label: "Profile",
          ),
        ],
      ),
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
      body: loading
          // ignore: avoid_unnecessary_containers
          ? Container(
              child: const Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // ignore: avoid_unnecessary_containers, sized_box_for_whitespace
                    Container(
                      height: 70,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: category.length,
                          itemBuilder: (context, index) {
                            return CategoryTile(category[index].imageUrl,
                                category[index].categoryName);
                          }),
                    ),
                    // ignore: avoid_unnecessary_containers
                    Container(
                      child: articles.isEmpty
                          // ignore: avoid_unnecessary_containers
                          ? Center(
                              child: AlertDialog(
                                title: Text(
                                    "No News Available at this Time Kindly wait a second or try other category THANK YOU!"),
                              ),
                            )
                          : ListView.builder(
                              itemCount: articles.length,
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return BlogTile(
                                    articles[index].urlToImage,
                                    articles[index].title,
                                    articles[index].description,
                                    articles[index].url);
                              },
                            ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
//creating category section

class CategoryTile extends StatefulWidget {
  final String imageUrl, categoryName;
// ignore: prefer_const_constructors_in_immutables,
  CategoryTile(this.imageUrl, this.categoryName);

  @override
  State<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        categoryyy = widget.categoryName;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            articles.clear();
            return CategoryNewsSection(
              categoryy: categoryyy,
            );
          }),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.only(top: 10),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              child: CachedNetworkImage(
                imageUrl: widget.imageUrl,
                width: 120,
                height: 60,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(7),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.black45),
              child: Text(
                widget.categoryName,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryModel {
  String categoryName;
  String imageUrl;
  CategoryModel(this.categoryName, this.imageUrl);
}
//category ui section done

//getting data from api

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

List<NewsApi> articles = [];

Future<void> getNews(String catg) async {
  try {
    print(catg);
    // String apikey =
    //     "https://newsapi.org/v2/top-headlines?category=$catg&apiKey=f76afcf58a4e42fea62d8eacc3cb0e5d";
    // String apikey =
    //     "https://newsapi.org/v2/top-headlines?country=&apiKey=f76afcf58a4e42fea62d8eacc3cb0e5d";
    String apikey =
        "https://newsapi.org/v2/top-headlines?category=$catg&country=us&apiKey=f24e415df31341a19f07541381594335";

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
  } catch (e) {
    print(e);
    // print(apikey);
  }
}

//Now creating UI for news
class BlogTile extends StatefulWidget {
  final String imageUrl, title, desc, url;
  // ignore: prefer_const_constructors_in_immutables,
  BlogTile(this.imageUrl, this.title, this.desc, this.url);

  @override
  State<BlogTile> createState() => _BlogTileState();
}

class _BlogTileState extends State<BlogTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InApp(url: widget.url),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Image.network(
                    "https://www.prestashop.com/sites/default/files/styles/blog_750x320/public/blog/2019/10/banner_error_404.jpg?itok=eAS4swln",
                    fit: BoxFit.cover,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              widget.title,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.desc,
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
            GestureDetector(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                var email = prefs.getString('email');
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.setString('title', widget.title);
                preferences.setString('description', widget.desc);
                preferences.setString('urlToImage', widget.imageUrl);
                preferences.setString('url', widget.url);
                print(email);

                dataa.add(FavoriteNews(
                  title: preferences.getString('title'),
                  description: preferences.getString('description'),
                  urlToImage: preferences.getString('urlToImage'),
                  url: preferences.getString('url'),
                ));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => email == null ? Login() : Favorite(),
                  ),
                );
              },
              child: Container(
                  alignment: Alignment.bottomRight,
                  child: Icon(
                    Icons.favorite,
                    size: 30,
                    color: Colors.red,
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class FavoriteNews {
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  FavoriteNews(
      {required this.title,
      required this.description,
      required this.urlToImage,
      required this.url});
}

List<FavoriteNews> dataa = [];
