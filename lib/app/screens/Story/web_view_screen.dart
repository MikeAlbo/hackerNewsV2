import 'package:flutter/material.dart';
import 'package:hacker_news/Models/item.dart';
import 'package:hacker_news/app/screens/Story/bottom_app_bar.dart';
import 'package:hacker_news/app/widgets/app_bar.dart';

class WebViewScreen extends StatefulWidget {
  final ItemModel itemModel;
  WebViewScreen({this.itemModel});
  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildBottomAppBar(),
      appBar: buildAppBar(title: widget.itemModel.title, centerTitle: true),
      body: Container(
        child: Center(
          child: Text("${widget.itemModel.title} -- WebView"),
        ),
      ),
    );
  }
}
