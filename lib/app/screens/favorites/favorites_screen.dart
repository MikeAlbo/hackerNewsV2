import 'package:flutter/material.dart';
import 'package:hacker_news/BLOCs/Items/items_provider.dart';
import 'package:hacker_news/BLOCs/Stories/stories_provider.dart';
import 'package:hacker_news/Models/item.dart';
import 'package:hacker_news/app/screens/favorites/favorites_tile.dart';
import 'package:hacker_news/app/widgets/app_bar.dart';
import 'package:hacker_news/app/widgets/fade_animation.dart';
import 'package:hacker_news/app/widgets/placeholder_tile.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    StoriesBloc storiesBloc = StoriesProvider.of(context);
    ItemsBloc itemsBloc = ItemsProvider.of(context);

    List<int> favorites = storiesBloc.getFavoritesList;

    void updateFavoritesList({int itemId}) {
      setState(() {
        storiesBloc.isItemAFavorite(itemId: itemId) == false
            ? favorites.add(itemId)
            : favorites.remove(itemId);
        storiesBloc.updateFavoritesList(itemId: itemId);
        favorites = storiesBloc.getFavoritesList;
      });
    }

//    if (favorites.length < 1) {
//      return Center(
//        child: Text(
//          "No Favorites yet...",
//          style: Theme.of(context).textTheme.subtitle1,
//        ),
//      );
//    }

    Widget noFavoritesYet() {
      return Center(
        child: Text(
          "No Favorites yet...",
          style: Theme.of(context).textTheme.subtitle1,
        ),
      );
    }

    return Scaffold(
      appBar: buildAppBar(title: "Favorites", centerTitle: false),
      body: favorites.length < 2
          ? noFavoritesYet()
          : FadeAnimation(
              duration: Duration(milliseconds: 500),
              child: ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (BuildContext ctx, int index) {
                  //return Center(child: Text("Item ID: ${favorites[index]}"));
                  itemsBloc.fetchItem(favorites[index]);
                  return StreamBuilder(
                    stream: itemsBloc.itemsOutput,
                    builder: (BuildContext ctx,
                        AsyncSnapshot<Map<int, Future<ItemModel>>>
                            itemSnapshot) {
                      if (!itemSnapshot.hasData) {
                        return PlaceHolderTile();
                      }
                      return FutureBuilder(
                        future: itemSnapshot.data[favorites[index]],
                        builder: (BuildContext ctx,
                            AsyncSnapshot<ItemModel> snapshot) {
                          if (!snapshot.hasData) {
                            return PlaceHolderTile();
                          }
                          return FavoritesListTile(
                            itemModel: snapshot.data,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
    );
  }
}
