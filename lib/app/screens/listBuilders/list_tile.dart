import 'package:flutter/material.dart';
import 'package:hacker_news/APIs/api_helpers.dart';

import '../../../Models/item.dart';
import '../helpers.dart';

//todo: replace fake icon colors and icon with actual data driven params

Widget buildListTile(
    {BuildContext context, ItemModel item, IdListName idListName}) {
  return ListTile(
    contentPadding: EdgeInsets.all(15.0),
    //isThreeLine: item.url != "" ? true : false,
    title: Text(
      item.title,
      overflow: TextOverflow.ellipsis,
    ),
    subtitle: subtitleBuilder(itemModel: item, idListName: idListName),
    trailing: IconButton(
      color: item.id % 2 == 0 ? Colors.grey[400] : Colors.redAccent,
      icon:
          item.id % 2 == 0 ? Icon(Icons.bookmark_border) : Icon(Icons.bookmark),
      onPressed: () {},
    ),
  );
}

Widget subtitleBuilder({ItemModel itemModel, IdListName idListName}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            chooseArticleIcon(idListName: idListName),
            size: 12.0,
            color: Colors.grey[600],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              "${formatDateByString(itemModel: itemModel)}",
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 2.0),
        child: Text(
          "${trimUrl(itemModel.url)} ",
          overflow: TextOverflow.fade,
        ),
      ),
    ],
  );
}
