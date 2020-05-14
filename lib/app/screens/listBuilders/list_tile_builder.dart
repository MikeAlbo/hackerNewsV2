import 'package:flutter/material.dart';
import 'package:hacker_news/APIs/api_helpers.dart';
import 'package:hacker_news/BLOCs/Items/items_bloc.dart';
import 'package:hacker_news/BLOCs/Items/items_provider.dart';
import 'package:hacker_news/Models/item.dart';
import 'package:hacker_news/app/screens/listBuilders/list_tile.dart';
import 'package:hacker_news/app/widgets/placeholder_tile.dart';

class ListTileBuilder extends StatelessWidget {
  final int id;
  final IdListName idListName;

  ListTileBuilder({this.id, this.idListName});

  @override
  Widget build(BuildContext context) {
    final ItemsBloc itemsBloc = ItemsProvider.of(context);
    itemsBloc.fetchItem(id);
    return StreamBuilder(
      stream: itemsBloc.itemsOutput,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Text("");
        }
        return FutureBuilder(
          future: snapshot.data[id],
          builder:
              (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return PlaceHolderTile();
            }
            return buildListTile(
                context: context,
                item: itemSnapshot.data,
                idListName: idListName);
          },
        );
      },
    );
  }
}
