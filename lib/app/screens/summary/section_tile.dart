import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hacker_news/APIs/api_helpers.dart';
import 'package:hacker_news/BLOCs/Items/items_provider.dart';
import 'package:hacker_news/Models/item.dart';
import 'package:hacker_news/app/widgets/placeholder_tile.dart';

import '../helpers.dart';

//todo: could possibly use ListTileBuilder and return a widget that is passed to the constructor

class SectionTile extends StatelessWidget {
  final IdListName idListName;
  final int itemId;

  SectionTile({this.itemId, this.idListName});

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
          return PlaceHolderTile();
        }
        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (BuildContext ctx, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return PlaceHolderTile();
            }

            return buildCardLayout(
                ctx: ctx, itemModel: itemSnapshot.data, idListName: idListName);
          },
        );
      },
    );
  }
}

Widget buildCardLayout(
    {BuildContext ctx, ItemModel itemModel, IdListName idListName}) {
  return Column(
    children: <Widget>[
      ListTile(
        contentPadding: EdgeInsets.all(12.0),
        leading: Icon(
          chooseArticleIcon(idListName: idListName),
          size: 20.0,
          color: Colors.blueGrey,
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.bookmark,
            color: Colors.grey[400],
          ),
          onPressed: () {},
        ),
        title: Text(
          itemModel.title,
          overflow: TextOverflow.visible,
        ),
        subtitle: _buildListBody(ctx: ctx, itemModel: itemModel),
      ),
      insertDivider(isTitle: false),
    ],
  );
}

Widget _buildListBody({BuildContext ctx, ItemModel itemModel}) {
  final String bodyText = itemModel.text == ""
      ? null
      : trimBodyText(
          originalText: itemModel.text,
          padDirection: PadDirection.padRight,
          padChar: ".");

  final Text dateAndByText = Text(formatDateByString(itemModel: itemModel));
  final String linkText = trimUrl(itemModel.url);

  print("Link Text --> $linkText");

  List<Widget> bodyElements = [];
  if (bodyText != null) {
    bodyElements.add(Html(
      data: bodyText,
    ));
  }
  bodyElements.add(dateAndByText);

  if (linkText != "" || linkText != null) {
    bodyElements.add(Text(linkText));
  }

  return ListBody(
    children: bodyElements,
  );
}
