import 'package:flutter/material.dart';
import 'package:hacker_news/BLOCs/Comments/comments_bloc.dart';
import 'package:hacker_news/BLOCs/Comments/comments_provider.dart';
import 'package:hacker_news/Models/item.dart';
import 'package:hacker_news/app/screens/Story/Comments/comments_tile.dart';
import 'package:hacker_news/app/widgets/placeholder_tile.dart';

enum NumberOfComments { subset, all }

class CommentsListBuilder extends StatelessWidget {
  final NumberOfComments numberOfComments;
  final ItemModel itemModel;

  CommentsListBuilder({this.itemModel, this.numberOfComments});

  @override
  Widget build(BuildContext context) {
    print("hello ${itemModel.title}");
    List<int> idsToFetch = reduceKidsToLimit(itemModel);
    CommentsBloc commentsBloc = CommentsProvider.of(context);
    if (idsToFetch != null) {
      idsToFetch.forEach((id) => commentsBloc.fetchComment(id));
    }
    return Container(
      color: Colors.white,
      child: idsToFetch == null
          ? _noCommentsYet(context)
          : StreamBuilder(
              stream: commentsBloc.commentsOutput,
              builder: (BuildContext ctx,
                  AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    color: Colors.white,
                    //constraints: BoxConstraints.expand(),
                  );
                }
                return Column(
                  children: idsToFetch
                      .map((id) => _buildFutureBuildCommentList(
                          idsToFetch: idsToFetch,
                          itemFuture: snapshot.data[id],
                          itemMap: snapshot.data))
                      .toList()
                      .cast<Widget>(),
                );
              },
            ),
    );
  }
}

_noCommentsYet(BuildContext context) {
  return Container(
    color: Colors.white,
    height: 200.0,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "No Comments Yet",
          style: Theme.of(context).textTheme.subtitle1,
        ),
        Icon(Icons.mood_bad, size: 40.0, color: Colors.blueGrey),
      ],
    ),
  );
}

_buildFutureBuildCommentList(
    {Future<ItemModel> itemFuture,
    Map<int, Future<ItemModel>> itemMap,
    List<int> idsToFetch}) {
  return FutureBuilder(
    future: itemFuture,
    builder: (BuildContext ctx, AsyncSnapshot<ItemModel> itemSnapshot) {
      if (!itemSnapshot.hasData) {
        return PlaceHolderTile();
      }

      return Column(
        children: buildList(item: itemSnapshot.data, itemMap: itemMap),
      );
    },
  );
}

List<Widget> buildList(
    {@required ItemModel item, @required Map<int, Future<ItemModel>> itemMap}) {
  final children = <CommentsTile>[];
  final commentsList = item.kids.map((kidId) {
    return CommentsTile(
      itemId: kidId,
      itemMap: itemMap,
      depth: 1,
    );
  }).toList();

  children.addAll(commentsList);

  return children;

//  return ListView(
//    children: children,
//  );
}

List<int> reduceKidsToLimit(ItemModel itemModel, {int subsetLength = 5}) {
  List<int> kids = itemModel.kids.cast<int>();
  if (kids.length < 1) {
    return null;
  } else if (kids.length < subsetLength) {
    return kids;
  } else {
    return kids.sublist(0, subsetLength - 1);
  }
}
