import 'package:flutter/material.dart';
import 'package:hacker_news/APIs/api_helpers.dart';
import 'package:hacker_news/BLOCs/Favorites/favorites_bloc.dart';
import 'package:hacker_news/BLOCs/Items/items_bloc.dart';
import 'package:hacker_news/BLOCs/Items/items_provider.dart';
import 'package:hacker_news/Models/item.dart';
import 'package:hacker_news/app/widgets/placeholder_tile.dart';

import '../helpers.dart';

class ListTileBuilder extends StatefulWidget {
  final int id;
  final IdListName idListName;
  final FavoritesBloc favoritesBloc;

  ListTileBuilder({this.id, this.idListName, this.favoritesBloc});

  @override
  _ListTileBuilderState createState() => _ListTileBuilderState();
}

class _ListTileBuilderState extends State<ListTileBuilder> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    isSelected = widget.favoritesBloc.doesIdExistInFavorites(widget.id);
    final ItemsBloc itemsBloc = ItemsProvider.of(context);
    itemsBloc.fetchItem(widget.id);
    return StreamBuilder(
      stream: itemsBloc.itemsOutput,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return PlaceHolderTile();
        }
        return FutureBuilder(
          future: snapshot.data[widget.id],
          builder:
              (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return PlaceHolderTile();
            }
            ItemModel item = itemSnapshot.data;
            return ListTile(
              onTap: () {
                print("tile tapped");
                Navigator.pushNamed(context, "/story", arguments: item);
              },
              contentPadding: EdgeInsets.all(15.0),
              //isThreeLine: item.url != "" ? true : false,
              title: Text(
                item.title,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: subtitleBuilder(
                  itemModel: item, idListName: widget.idListName),
              trailing: IconButton(
                color: isSelected ? Colors.redAccent : Colors.grey[400],
                icon: isSelected
                    ? Icon(Icons.bookmark)
                    : Icon(Icons.bookmark_border),
                onPressed: () {
                  widget.favoritesBloc.updateItemInFavorites(widget.id);
                  setState(() {});
                },
              ),
            );
          },
        );
      },
    );
  }

//  @override
//  void dispose() {
//    widget.favoritesBloc.updateUserPrefStore;
//    super.dispose();
//  }
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
