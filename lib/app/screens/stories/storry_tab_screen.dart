import 'package:flutter/material.dart';
import 'package:hacker_news/APIs/api_helpers.dart';
import 'package:hacker_news/BLOCs/Favorites/favorites_bloc.dart';
import 'package:hacker_news/BLOCs/Favorites/favorites_provider.dart';
import 'package:hacker_news/BLOCs/Stories/stories_provider.dart';
import 'package:hacker_news/app/screens/listBuilders/list_tile_builder.dart';
import 'package:hacker_news/app/widgets/fade_animation.dart';
import 'package:hacker_news/app/widgets/placeholder_tile.dart';

import '../../../Models/ids_list.dart';
import '../helpers.dart';

//todo: refactor buildListView into this widget

class StoryTabScreen extends StatefulWidget {
  final StoriesBloc storiesBloc;
  final IdListName idListName;

  StoryTabScreen({this.storiesBloc, this.idListName});
  @override
  _StoryTabScreenState createState() => _StoryTabScreenState();
}

class _StoryTabScreenState extends State<StoryTabScreen> {
  @override
  void initState() {
    widget.storiesBloc.fetchAllList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FavoritesBloc favoritesBloc = FavoritesProvider.of(context);
    return FadeAnimation(
      duration: Duration(seconds: 1),
      child: StreamBuilder(
        stream: widget.storiesBloc.listOfIds,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, IdsListModel>> snapshot) {
          if (!snapshot.hasData) {
            return PlaceHolderTile(); //todo: add placeholder
          }

          List<int> _idsList = snapshot
              .data[getStoriesList(widget.idListName)].storyIdsList
              .cast<int>();

          return Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: ListView.builder(
                itemCount: _idsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      ListTileBuilder(
                        id: _idsList[index],
                        idListName: widget.idListName,
                        favoritesBloc: favoritesBloc,
                      ),
                      insertDivider(isTitle: false),
                    ],
                  );
                }),
          );
        },
      ),
    );
    //return buildFakeScreen(widget.idListName);
  }
}
