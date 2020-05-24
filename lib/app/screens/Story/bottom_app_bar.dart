import 'package:flutter/material.dart';
import 'package:hacker_news/Models/item.dart';

import 'layout_view_screen.dart';

Widget buildBottomAppBar(
    {BuildContext context,
    ItemModel itemModel,
    bool isFavorite,
    Function updateFavorites}) {
  print("is favorite! --> $isFavorite");
  return BottomAppBar(
    color: Colors.grey[100],
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        buildIconButton(icon: Icons.open_in_new, action: () {}),
        buildIconButton(
            icon: isFavorite ? Icons.bookmark : Icons.bookmark_border,
            action: () => updateFavorites(),
            favorite: isFavorite),
        buildIconButton(
          icon: Icons.share,
        ),
        buildIconButton(
            icon: Icons.question_answer,
            action: () =>
                navigateToCommentsPage(context: context, itemModel: itemModel)),
      ],
    ),
  );
}

IconButton buildIconButton(
    {IconData icon, Function action, bool favorite = false}) {
  return IconButton(
    icon: Icon(icon),
    onPressed: action,
    color: favorite ? Colors.redAccent : Colors.grey[600],
  );
}

navigateToCommentsPage({BuildContext context, ItemModel itemModel}) {
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
    return LayoutViewScreen(
      itemModel: itemModel,
    );
  }));
}
