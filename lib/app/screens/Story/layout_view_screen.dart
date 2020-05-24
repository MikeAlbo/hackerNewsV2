import 'package:flutter/material.dart';
import 'package:hacker_news/Models/item.dart';
import 'package:hacker_news/app/screens/Story/bottom_app_bar.dart';
import 'package:hacker_news/app/widgets/app_bar.dart';

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
      appBar: buildAppBar(title: widget.itemModel.title, centerTitle: true),
      bottomNavigationBar: BuildBottomAppBar(
        itemModel: widget.itemModel,
        viewMode: ViewMode.commentView,
      ),
      body: Center(
        child: Text("${widget.itemModel.type} -- layout  View"),
      ),
    );
  }
}
