import 'package:flutter/material.dart';
import 'package:hacker_news/APIs/api_helpers.dart';
import 'package:hacker_news/BLOCs/Stories/stories_bloc.dart';
import 'package:hacker_news/Models/ids_list.dart';
import 'package:hacker_news/app/widgets/placeholder_tile.dart';

import '../helpers.dart';
import 'list_tile_builder.dart';

//todo: add refresh

Widget buildListView({StoriesBloc storiesBloc}) {
  IdListName idListName = storiesBloc.getIdListName;
  //storiesBloc.getUserPrefs();
  return StreamBuilder(
    stream: storiesBloc.singleListOfIds,
    builder: (BuildContext context, AsyncSnapshot<IdsListModel> snapshot) {
      if (!snapshot.hasData) {
        return PlaceHolderTile(); //todo: add placeholder
      }

      return Container(
        padding: EdgeInsets.only(left: 5.0, right: 5.0),
        child: ListView.builder(
            itemCount: snapshot.data.storyIdsList.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  ListTileBuilder(
                    id: snapshot.data.storyIdsList[index],
                    idListName: idListName,
                  ),
                  insertDivider(isTitle: false),
                ],
              );
            }),
      );
    },
  );
}
