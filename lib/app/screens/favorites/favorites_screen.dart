import 'package:flutter/material.dart';
import 'package:hacker_news/BLOCs/Favorites/favorites_bloc.dart';
import 'package:hacker_news/BLOCs/Favorites/favorites_provider.dart';
import 'package:hacker_news/BLOCs/Items/items_provider.dart';
import 'package:hacker_news/Models/item.dart';
import 'package:hacker_news/app/widgets/fade_animation.dart';
import 'package:hacker_news/app/widgets/placeholder_tile.dart';

import 'dismiss.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    ItemsBloc itemsBloc = ItemsProvider.of(context);
    FavoritesBloc favoritesBloc = FavoritesProvider.of(context);
    List<int> favorites = favoritesBloc.getFavorites;

    return FadeAnimation(
      duration: Duration(milliseconds: 500),
      child: favorites.length < 1
          ? noFavoritesYet(context)
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (BuildContext ctx, int index) {
                itemsBloc.fetchItem(favorites[index]);
                return StreamBuilder(
                  stream: itemsBloc.itemsOutput,
                  builder: (BuildContext ctx,
                      AsyncSnapshot<Map<int, Future<ItemModel>>> itemSnapshot) {
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
                          return DismissFavorite(
                              itemModel: snapshot.data,
                              child: ListTile(
                                title: Text("${snapshot.data.title}"),
                              ),
                              onDismiss: (direction) {
                                favoritesBloc
                                    .updateItemInFavorites(snapshot.data.id);
                                favorites = favoritesBloc.getFavorites;
                                setState(() {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "${snapshot.data.title} -- removed"),
                                  ));
                                });
                              });
                        });
                  },
                );
              },
            ),
    );
  }
}

Widget noFavoritesYet(context) {
  return Center(
    child: Text(
      "No Favorites yet...",
      style: Theme.of(context).textTheme.subtitle1,
    ),
  );
}
