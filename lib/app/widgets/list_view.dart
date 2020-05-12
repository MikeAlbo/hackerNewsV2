import 'package:flutter/material.dart';
import 'package:hacker_news/BLOCs/Items/items_bloc.dart';
import 'package:hacker_news/BLOCs/Stories/stories_bloc.dart';
import 'package:hacker_news/Models/ids_list.dart';
import 'package:hacker_news/app/screens/listBuilders/list_tile_builder.dart';

//todo: add refresh

Widget buildListView({StoriesBloc storiesBloc, ItemsBloc itemsBloc}) {
  return StreamBuilder(
    stream: storiesBloc.singleListOfIds,
    builder: (BuildContext context, AsyncSnapshot<IdsListModel> snapshot) {
      if (!snapshot.hasData) {
        return Text("no data yet"); //todo: add placeholder
      }
      return Container(
        padding: EdgeInsets.only(left: 5.0, right: 5.0),
        child: ListView.builder(
            itemCount: snapshot.data.storyIdsList.length,
            itemBuilder: (BuildContext context, int index) {
              return buildTile(
                  id: snapshot.data.storyIdsList[index], itemsBloc: itemsBloc);
            }),
      );
    },
  );
}

Divider insertDivider({@required bool isTitle}) {
  return Divider(
    thickness: isTitle ? 1.0 : 0.5,
    height: 1.0,
    color: isTitle ? Colors.black87 : Colors.grey[300],
  );
}

Widget buildTile({int id, ItemsBloc itemsBloc}) {
  return Column(
    children: <Widget>[
      ListTileBuilder(
        id: id,
        itemsBloc: itemsBloc,
      ),
      insertDivider(isTitle: false),
    ],
  );
}
