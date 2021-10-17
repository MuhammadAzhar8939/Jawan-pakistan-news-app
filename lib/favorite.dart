import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_app/inappwebview.dart';

// ignore: use_key_in_widget_constructors
class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final Stream<QuerySnapshot> _newsStream =
      FirebaseFirestore.instance.collection('favoriteNews').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _newsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          // ignore: prefer_const_constructors
          return Text("there is an error ");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          Duration.secondsPerHour;
          // ignore: prefer_const_constructors
          return CircularProgressIndicator();
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
          body: Container(
            color: Colors.black12,
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  String id = document.id;
                  data["id"] = id;
                  return BlogTilee(data["urlToImage"], data["title"],
                      data["description"], data["url"], data["id"]);
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

//Now creating UI for news
class BlogTilee extends StatefulWidget {
  final String imageUrl, title, desc, url, id;
  // ignore: prefer_const_constructors_in_immutables,, use_key_in_widget_constructors
  BlogTilee(this.imageUrl, this.title, this.desc, this.url, this.id);

  @override
  State<BlogTilee> createState() => _BlogTileeState();
}

class _BlogTileeState extends State<BlogTilee> {
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
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  // ignore: prefer_const_constructors
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
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () async {
                await remove(widget.id);
              },
              child: Container(
                  alignment: Alignment.bottomRight,
                  // ignore: prefer_const_constructors
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

remove(String id) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection("favoriteNews").doc(id).delete();
  } catch (e) {
    // ignore: avoid_print
    print(e);
  }
}
