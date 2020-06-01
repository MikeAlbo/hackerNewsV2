import 'package:flutter/material.dart';
import 'package:hacker_news/Models/item.dart';
import 'package:hacker_news/app/screens/Story/Comments/comments_list_builder.dart';
import 'package:hacker_news/app/screens/Story/LayoutViewSlivers/layout_body_sliver.dart';
import 'package:hacker_news/app/screens/Story/bottom_app_bar.dart';

import 'LayoutViewSlivers/layout_appbar_sliver.dart';
import 'LayoutViewSlivers/layout_title_sliver.dart';

class LayoutViewScreen extends StatelessWidget {
  final ItemModel itemModel;

  LayoutViewScreen({this.itemModel});

  @override
  Widget build(BuildContext context) {
    List<Widget> slivers = [
      LayoutAppBarSliver(
        title: itemModel.type,
      ),
      LayoutTitleSliver(
        title: itemModel.title,
      ),
    ];

    SliverChildListDelegate sliverChildListDelegate = SliverChildListDelegate([
      LayoutBodySliver(
        itemModel: itemModel,
      ),
      CommentsListBuilder(
        numberOfComments: NumberOfComments.subset,
        itemModel: itemModel,
      )
    ]);

//    SliverFixedExtentList sliverFixedExtentList = SliverFixedExtentList(
//      itemExtent: 1000.0,
//      delegate: sliverChildListDelegate,
//    );
//
//    SliverFillViewport sliverFillViewport = SliverFillViewport(
//      delegate: sliverChildListDelegate,
//    );

    SliverList sliverList = SliverList(
      delegate: sliverChildListDelegate,
    );

    slivers.add(sliverList);

    return Scaffold(
      bottomNavigationBar: BuildBottomAppBar(
        itemModel: itemModel,
        viewMode: ViewMode.commentView,
      ),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: slivers,
      ),
    );
  }
}

/*
*
* getter should add a list of ids to a stream
* bloc should recursively get and return the children of those items
* if children length is longer than init get, then show user a load more button
* attempt to add additional comments to page, do not loose scroll position if state is changed
* if end of comments show "end of comments"
* if no comments show "no comments"
* -- maybe --should return a new page with a ListView.builder to progressively load long list of comments
*
*/
