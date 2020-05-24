import 'package:flutter/material.dart';
import 'package:hacker_news/BLOCs/Favorites/favorites_provider.dart';
import 'package:hacker_news/Models/item.dart';
import 'package:hacker_news/app/screens/Story/layout_view_screen.dart';
import 'package:hacker_news/app/screens/Story/web_view_screen.dart';

/*
* Story View Screen
*
* takes an item object from the listTile
* decides whether to load a url webview or not (if exist)
* determine if there are comments or not
* determine if there is text or not
*
* show an tab bar at the bottom of the screen, even with webview
* show an app bar with the listName as the title (possibly with list logo)
* button bar - be able to favorite the item, show as favorite if exist
* be able to share items *** if it works!
* ability to open web page in browser
* */

//todo: handle favorites interaction
//todo: handle share interaction
// todo: reset state on list items when navigating back to show favorites updated

class StoryViewScreen extends StatelessWidget {
  final ItemModel itemModel;
  StoryViewScreen({this.itemModel});
  @override
  Widget build(BuildContext context) {
    final FavoritesBloc favoritesBloc = FavoritesProvider.of(context);
    return itemModel.url == ""
        ? LayoutViewScreen(
            itemModel: itemModel,
            favoritesBloc: favoritesBloc,
          )
        : WebViewScreen(
            itemModel: itemModel,
            favoritesBloc: favoritesBloc,
          );
  }
}
