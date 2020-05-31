import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hacker_news/Models/item.dart';
import 'package:hacker_news/app/screens/helpers.dart';

class LayoutBodySliver extends StatelessWidget {
  final ItemModel itemModel;

  LayoutBodySliver({this.itemModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: itemModel.kids.length < 1
                  ? Text("")
                  : Text(trimUrl(itemModel.url)),
            ),
            _buildSubTitle(itemModel),
            Container(
              child: insertDivider(isTitle: false),
              width: 300.0,
            ),
            itemModel.text == ""
                ? Text("")
                : _buildBodyText(itemModel.text, context),
            Container(
              child: itemModel.kids.length < 1 || itemModel.text == ""
                  ? Text("")
                  : insertDivider(isTitle: true),
              width: 300.0,
            ),
            _buildCommentHeader(
              context,
              itemModel,
            ),
            Container(
              child: itemModel.kids.length < 1
                  ? Text("")
                  : insertDivider(isTitle: false),
              width: 300.0,
            ),
          ],
        ),
      ),
    );
  }
}

_buildSubTitle(ItemModel itemModel) {
  return Container(
    margin: EdgeInsets.only(bottom: 15.0),
    // color: Colors.red,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "by : ${itemModel.by}",
          style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
        ),
        Text(
          "|",
          style: TextStyle(fontSize: 20.0, color: Colors.grey[600]),
        ),
        Text(
          formatDate(time: itemModel.time),
          style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
        ),
      ],
    ),
  );
}

_buildBodyText(String text, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
//    child: Text(
//      text,
//      style: TextStyle(height: 1.5, fontSize: 16.0),
//      textAlign: TextAlign.center,
//      softWrap: true,
//    ),
    child: Html(
      data: text,
    ),
  );
}

Widget _buildCommentHeader(BuildContext context, ItemModel itemModel) {
  String output;
  int kidsLength = itemModel.kids.length;
  if (kidsLength > 5) {
    output = "Showing 5 of $kidsLength comments";
  } else {
    output =
        "Showing ${kidsLength != 1 ? "all" : "the"} $kidsLength comment${kidsLength != 1 ? "s" : ""}";
  }
  return kidsLength < 1
      ? Text("")
      : Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                output,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w200),
              ),
              kidsLength <= 5
                  ? Text("")
                  : MaterialButton(
                      color: Colors.grey[200],
                      elevation: 1.0,
                      textColor: Colors.blue,
                      child: Text("Show All Comments"),
                      onPressed: () {
                        Navigator.pushNamed(context, "/comments",
                            arguments: itemModel);
                      },
                    ), //todo: seriously need to improve style lol
            ],
          ),
        );
}
