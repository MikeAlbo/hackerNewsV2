import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hacker_news/Models/item.dart';
import 'package:hacker_news/app/screens/helpers.dart';

//todo: handle the comment body text more effectively
//todo: handle html rendering and layout
//todo: handle comment deleted more effectively

class CommentsTile extends StatelessWidget {
  final int itemId;
  final int depth;
  final Map<int, Future<ItemModel>> itemMap;

  CommentsTile({this.itemId, this.depth, this.itemMap});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (BuildContext context, AsyncSnapshot<ItemModel> iteSnapshot) {
        if (!iteSnapshot.hasData) {
          return Text(
              "Item Snapshot for comment has no data"); //todo: add in placeholder
        }
        final item = iteSnapshot.data;

        final children = <Widget>[
          ListTile(
            contentPadding: EdgeInsets.only(left: depth * 10.0, right: 16.0),
            //leading: _buildLeadingIcon(),
            leading: Text("$depth"),
            title: item.text == ""
                ? Text("")
                : Html(
                    data: item.text,
                  ),
            subtitle:
                item.by == "" ? Text("Comment Deleted") : Text("${item.by}"),
          ),
          insertDivider(isTitle: false),
        ];

        iteSnapshot.data.kids.forEach((kidId) {
          children.add(CommentsTile(
            itemMap: itemMap,
            itemId: kidId,
            depth: depth + 1,
          ));
        });

        return Column(
          children: children,
        );
      },
    );
  }

  // build the leading icon for the tile
  _buildLeadingIcon() {
    return Container(
      padding: EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 1.0, color: Colors.black26),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            depth == 1 ? Icons.comment : Icons.reply,
            color: Colors
                .grey[1000 - (depth * 100) > 100 ? 1000 - (depth * 100) : 100],
            size: 20.0,
          ),
        ],
      ),
    );
  }
}
