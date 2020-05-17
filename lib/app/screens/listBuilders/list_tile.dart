import 'package:flutter/material.dart';
import 'package:hacker_news/APIs/api_helpers.dart';
import 'package:hacker_news/BLOCs/Stories/stories_provider.dart';

import '../../../Models/item.dart';
import '../helpers.dart';

//todo: replace fake icon colors and icon with actual data driven params

class BuildListTile extends StatefulWidget {
  final ItemModel itemModel;
  final IdListName idListName;

  BuildListTile({this.idListName, this.itemModel});

  @override
  _BuildListTileState createState() => _BuildListTileState();
}

class _BuildListTileState extends State<BuildListTile> {
  @override
  Widget build(BuildContext context) {
    StoriesBloc storiesBloc = StoriesProvider.of(context);
    bool isSelected = storiesBloc.isItemAFavorite(itemId: widget.itemModel.id);
    return ListTile(
      contentPadding: EdgeInsets.all(15.0),
      //isThreeLine: item.url != "" ? true : false,
      title: Text(
        widget.itemModel.title,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: subtitleBuilder(
          itemModel: widget.itemModel, idListName: widget.idListName),
      trailing: IconButton(
        color: isSelected ? Colors.redAccent : Colors.grey[400],
        icon: isSelected ? Icon(Icons.bookmark) : Icon(Icons.bookmark_border),
        onPressed: () {
          setState(() {
            storiesBloc.updateFavoritesList(itemId: widget.itemModel.id);
          });
        },
      ),
    );
  }
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
