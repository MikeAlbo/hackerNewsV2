import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hacker_news/Models/item.dart';

//todo: handle the comment body text more effectively
//todo: handle html rendering and layout
//todo: handle comment deleted more effectively

class CommentsTile extends StatelessWidget {
  final ItemModel itemModel;
  final int depth;

  CommentsTile({this.itemModel, this.depth});

  @override
  Widget build(BuildContext context) {
    _buildLeadingIcon() {
      return Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(width: 1.0, color: Colors.white24),
          ),
        ),
        child: Icon(depth == 1 ? Icons.comment : Icons.reply),
      );
    }

    return ListTile(
      leading: _buildLeadingIcon(),
      title: itemModel.text == ""
          ? ""
          : Html(
              data: itemModel.text,
            ),
      subtitle: itemModel.by == ""
          ? Text("Comment Deleted")
          : Text("${itemModel.by}"),
    );
  }
}
