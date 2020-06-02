import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hacker_news/Models/item.dart';
import 'package:hacker_news/app/screens/helpers.dart';
import 'package:html/parser.dart' show parse;

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
            _buildSubTitle(itemModel),
            itemModel.text == ""
                ? Text("")
                : _buildBodyText(itemModel.text, context),
            Container(
              child: itemModel.kids.length < 1 || itemModel.text == ""
                  ? Text("")
                  : insertDivider(isTitle: false),
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
    margin: EdgeInsets.only(bottom: 15.0, top: 10.0),
    padding: EdgeInsets.only(left: 15.0, right: 15.0),
    // color: Colors.red,
    child: FittedBox(
      fit: BoxFit.fitWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "by : ${itemModel.by} ",
            style: TextStyle(fontSize: 18.0, color: Colors.grey[600]),
          ),
          Text(
            " | ",
            style: TextStyle(fontSize: 20.0, color: Colors.grey[600]),
          ),
          Text(
            " ${formatDate(time: itemModel.time)} ",
            style: TextStyle(fontSize: 18.0, color: Colors.grey[600]),
          ),
          itemModel.url == ""
              ? Text("")
              : Text(
                  " | ",
                  style: TextStyle(fontSize: 20.0, color: Colors.grey[600]),
                ),
          itemModel.url == ""
              ? Text("")
              : FlatButton(
                  onPressed: () {},
                  child: Text(
                    "${trimUrl(itemModel.url)} ",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.blue[400],
                      //decoration: TextDecoration.underline,
                    ),
                  ),
                ),
        ],
      ),
    ),
  );
}

_buildBodyText(String text, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
    //child: renderHtmlBodyText(text),
    child: SelectableText.rich(
      TextSpan(
        text: parse(text).body.text,
        style: TextStyle(
          fontSize: 20.0,
          height: 1.5,
        ),
      ),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                output,
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
              ),
              kidsLength <= 5
                  ? Text("")
                  : FlatButton(
                      textColor: Colors.blueAccent[200],
                      child: Text("(Show All Comments)"),
                      onPressed: () {
                        Navigator.pushNamed(context, "/comments",
                            arguments: itemModel);
                      },
                    ), //todo: seriously need to improve style lol
            ],
          ),
        );
}
