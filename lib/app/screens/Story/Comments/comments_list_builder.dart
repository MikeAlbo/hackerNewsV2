import 'package:flutter/material.dart';
import 'package:hacker_news/BLOCs/Comments/comments_bloc.dart';
import 'package:hacker_news/BLOCs/Comments/comments_provider.dart';
import 'package:hacker_news/Models/item.dart';
import 'package:hacker_news/app/screens/Story/Comments/comments_tile.dart';

enum NumberOfComments { subset, all }

class CommentsListBuilder extends StatelessWidget {
  final NumberOfComments numberOfComments;
  final ItemModel itemModel;

  CommentsListBuilder({this.itemModel, this.numberOfComments});

  @override
  Widget build(BuildContext context) {
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

/*returns a Widget that displays to the user that there are currently no comments*/
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
        //return PlaceHolderTile();
        return Center(
          child: Text(
              "comment not loaded"), //todo: remove and replace with placeholder
        );
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
  children.add(CommentsTile(
    itemId: item.id,
    itemMap: itemMap,
    depth: 1,
  ));
//  final commentsList = item.kids.map((kidId) {
//    return CommentsTile(
//      itemId: kidId,
//      itemMap: itemMap,
//      depth: 2,
//    );
//  }).toList();

//  children.addAll(commentsList);

  return children;

//  return ListView(
//    children: children,
//  );
}

// return a subset list of the story's comments (kids property)
// returns null if there are no comments,
// returns the entire list of comments when the length of comments is greater than given subset length
// returns the entire list of comments when the length of comments is less than given subset length
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
