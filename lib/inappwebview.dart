import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class InApp extends StatefulWidget {
  String url;
  // ignore: use_key_in_widget_constructors, prefer_const_constructors_in_immutables
  InApp({required this.url});
  @override
  _InAppState createState() => _InAppState();
}

class _InAppState extends State<InApp> {
  double progress = 0;
  late InAppWebViewController webView;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "jawan pakistan",
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        actions: [
          Opacity(
            opacity: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(Icons.save),
            ),
          )
        ],
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
          )
        ],
      ),
    );
  }
}
