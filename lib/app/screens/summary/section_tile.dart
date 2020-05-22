import 'package:flutter/material.dart';
import 'package:hacker_news/APIs/api_helpers.dart';
import 'package:hacker_news/BLOCs/Favorites/favorites_provider.dart';
import 'package:hacker_news/BLOCs/Items/items_provider.dart';
import 'package:hacker_news/Models/item.dart';
import 'package:hacker_news/app/screens/summary/summary_list_tile.dart';
import 'package:hacker_news/app/widgets/placeholder_tile.dart';

//todo: could possibly use ListTileBuilder and return a widget that is passed to the constructor

class SectionTile extends StatelessWidget {
  final IdListName idListName;
  final int itemId;

  SectionTile({this.itemId, this.idListName});

  @override
  Widget build(BuildContext context) {
    FavoritesBloc favoritesBloc = FavoritesProvider.of(context);
    // init the items bloc
    ItemsBloc itemsBloc = ItemsProvider.of(context);
    // call fetch Id on the ID
    itemsBloc.fetchItem(itemId);
    return StreamBuilder(
      stream: itemsBloc.itemsOutput,
      builder: (BuildContext ctx,
          AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return PlaceHolderTile();
        }
        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (BuildContext ctx, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return PlaceHolderTile();
            }

//            return buildCardLayout(
//                ctx: ctx, itemModel: itemSnapshot.data, idListName: idListName);
            return SummaryListTile(
              itemModel: itemSnapshot.data,
              idListName: idListName,
              favoritesBloc: favoritesBloc,
            );
          },
        );
      },
    );
  }
}
