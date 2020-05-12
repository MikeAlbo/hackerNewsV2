import 'package:flutter/material.dart';
import 'package:hacker_news/Models/item.dart';

Widget buildListTile({BuildContext context, ItemModel itemModel}) {
  return ListTile(
    title: Text(itemModel.title),
    subtitle: Text(itemModel.by),
  );
}
