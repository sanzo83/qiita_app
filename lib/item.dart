import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ItemWidget extends StatelessWidget {

  String title;
  String url;

  ItemWidget({this.title, this.url});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: WebView(
        initialUrl: this.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}