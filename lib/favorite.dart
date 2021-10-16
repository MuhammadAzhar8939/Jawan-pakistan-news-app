import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'home.dart';

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
          body: SingleChildScrollView(
            child: Column(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return BlogTile(data["urlToImage"], data["title"],
                    data["description"], data["url"]);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

// return Scaffold(
             
//               // ignore: avoid_unnecessary_containers, prefer_const_constructors
//               body: Container(
//                 child: data.isEmpty
//                     // ignore: avoid_unnecessary_containers, prefer_const_constructors
//                     ? Center(
//                         // ignore: prefer_const_constructors
                        
//                         ),
//                       )
//                     : ListView.builder(
//                         itemCount: data.length,
//                         shrinkWrap: true,
//                         physics: const ClampingScrollPhysics(),
//                         itemBuilder: (context, index) {
//                           return BlogTile(data["urlToImage"], data["title"],
//                               data["description"], data["url"]);
//                         },
//                       ),
//               ),
//             );