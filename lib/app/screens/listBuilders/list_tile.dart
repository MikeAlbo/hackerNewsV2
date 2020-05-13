import 'package:flutter/material.dart';

import '../../../Models/item.dart';

//todo: replace fake icon colors and icon with actual data driven params

Widget buildListTile({BuildContext context, ItemModel item}) {
  return AnimatedOpacity(
    duration: Duration(seconds: 5),
    opacity: 1.0,
    child: ListTile(
      title: Text(
        item.title,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: subtitleBuilder(item),
      trailing: IconButton(
        color: item.id % 2 == 0 ? Colors.grey[400] : Colors.redAccent,
        icon: item.id % 2 == 0
            ? Icon(Icons.bookmark_border)
            : Icon(Icons.bookmark),
        onPressed: () {},
      ),
    ),
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
      Text("${itemModel.time}"),
    ],
  );
}
