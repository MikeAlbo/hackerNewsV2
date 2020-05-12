import 'package:flutter/material.dart';
import 'package:hacker_news/Models/item.dart';

Widget buildListTile({BuildContext context, ItemModel itemModel}) {
  return ListTile(
    title: Text(
      itemModel.title,
      overflow: TextOverflow.ellipsis,
    ),
    subtitle: subtitleBuilder(itemModel),
  );
}

Widget subtitleBuilder(ItemModel itemModel) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Text(itemModel.by),
      ),
      Text("${itemModel.score}"),
    ],
  );
}
