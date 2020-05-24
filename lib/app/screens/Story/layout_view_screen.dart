import 'package:flutter/material.dart';
import 'package:hacker_news/Models/item.dart';

class LayoutViewScreen extends StatefulWidget {
  final ItemModel itemModel;
  LayoutViewScreen({this.itemModel});
  @override
  _LayoutViewScreenState createState() => _LayoutViewScreenState();
}

class _LayoutViewScreenState extends State<LayoutViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.itemModel.title),
      ),
      body: Center(
        child: Text("${widget.itemModel.text ?? "no title"} -- layoutView"),
      ),
    );
  }
}
