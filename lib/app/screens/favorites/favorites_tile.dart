import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hacker_news/Models/item.dart';
import 'package:hacker_news/app/screens/helpers.dart';

//class FavoritesListTile extends StatefulWidget {
//  final ItemModel itemModel;
//  final StoriesBloc storiesBloc;
//
//  FavoritesListTile({this.itemModel, this.storiesBloc});
//
//  @override
//  _FavoritesListTileState createState() => _FavoritesListTileState();
//}

//class _FavoritesListTileState extends State<FavoritesListTile> {
//  @override
//  Widget build(BuildContext context) {
//    return Column(
//      children: <Widget>[
//          ListTile(
//            contentPadding: EdgeInsets.all(10.0),
//            leading: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Icon(
//                  Icons.check,
//                  color: Colors.grey[300],
//                ),
//                Text(
//                  "Read",
//                  style: Theme.of(context).textTheme.caption,
//                ),
//              ],
//            ),
//            title: Text(widget.itemModel.title),
//            subtitle: subtitleBuilder(itemModel: widget.itemModel),
//            trailing: Icon(Icons.chevron_right),
//          ),
//        insertDivider(isTitle: false),
//      ],
//    );
//  }
//}

class FavListTile extends StatelessWidget {
  final ItemModel itemModel;
  FavListTile({this.itemModel});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, "/story", arguments: itemModel);
          },
          contentPadding: EdgeInsets.all(10.0),
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.check,
                color: Colors.grey[300],
              ),
              Text(
                "Read",
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
          title: Text(itemModel.title),
          subtitle: subtitleBuilder(itemModel: itemModel),
          trailing: Icon(Icons.chevron_left),
        ),
        insertDivider(isTitle: false),
      ],
    );
  }
}

Widget subtitleBuilder({ItemModel itemModel}) {
  return Padding(
    padding: const EdgeInsets.only(top: 3.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "${formatDateByString(itemModel: itemModel)}",
              overflow: TextOverflow.fade,
            ),
          ],
        ),
        ListBody(
          children: <Widget>[
            itemModel.text != ""
                ? Html(
                    data: trimBodyText(
                        originalText: itemModel.text,
                        padChar: ".",
                        padLength: 3,
                        padDirection: PadDirection.padRight,
                        maxLength: 50),
                  )
                : Text(trimUrl(itemModel.url)),
          ],
        )
      ],
    ),
  );
}
