import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hacker_news/Models/item.dart';

class LayoutBodySliver extends StatelessWidget {
  final ItemModel itemModel;

  LayoutBodySliver({this.itemModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        color: Colors.green,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [Text(itemModel.by), Text("${itemModel.time}")],
            ),
            itemModel.text == "" ? Text(itemModel.url) : Text(itemModel.text),
          ],
        ),
      ),
    );
  }
}
