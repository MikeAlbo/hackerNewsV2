import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hacker_news/APIs/api_helpers.dart';
import 'package:hacker_news/BLOCs/Favorites/favorites_bloc.dart';
import 'package:hacker_news/Models/item.dart';

import '../helpers.dart';

class SummaryListTile extends StatefulWidget {
  final ItemModel itemModel;
  final IdListName idListName;
  final FavoritesBloc favoritesBloc;

  SummaryListTile({this.idListName, this.itemModel, this.favoritesBloc});

  @override
  _SummaryListTileState createState() => _SummaryListTileState();
}

class _SummaryListTileState extends State<SummaryListTile> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    isSelected =
        widget.favoritesBloc.doesIdExistInFavorites(widget.itemModel.id);
    return Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.all(12.0),
          leading: Icon(
            chooseArticleIcon(idListName: widget.idListName),
            size: 20.0,
            color: Colors.blueGrey,
          ),
          trailing: IconButton(
            icon: Icon(
              isSelected ? Icons.bookmark : Icons.bookmark_border,
              color: isSelected ? Colors.redAccent : Colors.grey[400],
            ),
            onPressed: () {
              widget.favoritesBloc.updateItemInFavorites(widget.itemModel.id);
              setState(() {});
            },
          ),
          title: Text(
            widget.itemModel.title,
            overflow: TextOverflow.visible,
          ),
          subtitle: _buildListBody(itemModel: widget.itemModel),
        ),
        insertDivider(isTitle: false),
      ],
    );
  }
}

Widget _buildListBody({ItemModel itemModel}) {
  final String bodyText = itemModel.text == ""
      ? null
      : trimBodyText(
          originalText: itemModel.text,
          padDirection: PadDirection.padRight,
          padChar: ".");

  final Text dateAndByText = Text(formatDateByString(itemModel: itemModel));
  final String linkText = trimUrl(itemModel.url);

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
