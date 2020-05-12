import 'package:flutter/material.dart';
import 'package:hacker_news/BLOCs/Items/items_bloc.dart';
import 'package:hacker_news/Models/item.dart';
import 'package:hacker_news/app/screens/listBuilders/list_tile.dart';

class ListTileBuilder extends StatelessWidget {
  final int id;
  final ItemsBloc itemsBloc;

  ListTileBuilder({this.id, this.itemsBloc});

  @override
  Widget build(BuildContext context) {
    itemsBloc.fetchItem(id);
    return StreamBuilder(
      stream: itemsBloc.itemsOutput,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Text("no item data"); //todo: loading icon
        }
        return FutureBuilder(
          future: snapshot.data[id],
          builder:
              (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Text(
                  "Item Snapshot has not data id: $id"); // todo: placeholder tile
            }
            return buildListTile(
                context: context, itemModel: itemSnapshot.data);
          },
        );
      },
    );
  }
}