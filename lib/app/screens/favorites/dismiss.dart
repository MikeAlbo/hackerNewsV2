import 'package:flutter/material.dart';
import 'package:hacker_news/Models/item.dart';

class DismissFavorite extends StatelessWidget {
  final Function(DismissDirection) onDismiss;
  final Widget child;
  final ItemModel itemModel;

  DismissFavorite({this.onDismiss, this.itemModel, this.child});
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: onDismiss,
      background: Container(
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Icon(
                Icons.delete,
                size: 40.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      key: Key("${itemModel.id}"),
      direction: DismissDirection.endToStart,
      child: child,
    );
  }
}
