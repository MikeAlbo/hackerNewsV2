import 'package:flutter/material.dart';
import 'package:hacker_news/BLOCs/Items/items_provider.dart';
import 'package:hacker_news/Models/item.dart';
import 'package:hacker_news/app/screens/listBuilders/list_view.dart';

//todo: could possibly use ListTileBuilder and return a widget that is passed to the constructor

class SectionTile extends StatelessWidget {
  final int itemId;

  SectionTile({this.itemId});

  @override
  Widget build(BuildContext context) {
    print("section tile: --> $itemId");
    // init the items bloc
    ItemsBloc itemsBloc = ItemsProvider.of(context);
    // call fetch Id on the ID
    itemsBloc.fetchItem(itemId);
    return StreamBuilder(
      stream: itemsBloc.itemsOutput,
      builder: (BuildContext ctx,
          AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Text("Future<ItemModel> snapshot has no data");
        }
        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (BuildContext ctx, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Text("ItemModel snapshot has no data");
            }

            return buildCardLayout(ctx: ctx, itemModel: itemSnapshot.data);
          },
        );
      },
    );
  }
}

Widget buildCardLayout({BuildContext ctx, ItemModel itemModel}) {
  return Column(
    children: <Widget>[
      ListTile(
        trailing: IconButton(
          icon: Icon(
            Icons.bookmark,
            color: Colors.grey[400],
          ),
          onPressed: () {},
        ),
        title: Text(
          itemModel.title,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: ListBody(
          children: <Widget>[
            Text(
              itemModel.text,
              overflow: TextOverflow.fade,
            ),
          ],
        ),
      ),
      insertDivider(isTitle: false),
    ],
  );
}
