import 'package:flutter/material.dart';
import 'package:hacker_news/BLOCs/Favorites/favorites_bloc.dart';
import 'package:hacker_news/Models/item.dart';

class LayoutViewScreen extends StatefulWidget {
  final ItemModel itemModel;
  final FavoritesBloc favoritesBloc;

  LayoutViewScreen({this.itemModel, this.favoritesBloc});
  @override
  _LayoutViewScreenState createState() => _LayoutViewScreenState();
}

class _LayoutViewScreenState extends State<LayoutViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.itemModel.title),
      ),
      body: Center(
        child: Text("${widget.itemModel.text ?? "no title"} -- layoutView"),
      ),
    );
  }
}
