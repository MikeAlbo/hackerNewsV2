import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:hacker_news/Models/item.dart';
import 'package:hacker_news/app/screens/Story/Comments/comments_list_builder.dart';
import 'package:hacker_news/app/screens/Story/LayoutViewSlivers/layout_body_sliver.dart';
import 'package:hacker_news/app/screens/Story/bottom_app_bar.dart';
import 'package:hacker_news/app/widgets/fade_animation.dart';

import 'LayoutViewSlivers/layout_appbar_sliver.dart';
import 'LayoutViewSlivers/layout_title_sliver.dart';

class LayoutViewScreen extends StatefulWidget {
  final ItemModel itemModel;

  LayoutViewScreen({this.itemModel});

  @override
  _LayoutViewScreenState createState() => _LayoutViewScreenState();
}

class _LayoutViewScreenState extends State<LayoutViewScreen> {
  ScrollController scrollController;

  String title;
  bool isScrollingDown = false;
  bool showBottomAppBar = true;

  void _showAppBar() {
    setState(() {
      showBottomAppBar = true;
      SystemChrome.setEnabledSystemUIOverlays(
          [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    });
  }

  void _hideAppBar() {
    setState(() {
      showBottomAppBar = false;
      SystemChrome.setEnabledSystemUIOverlays([]);
    });
  }

  /*
  * if scroll direction is reverse
  *   if reversedScroll var is false
  *     reversedScroll var = true
  *     showAppBar var is false
  *     hideAppBar() --> hides the bottom app bar, updates system icons, updates title
  * if scroll direction is forward
  *   reversedScroll var = false
  *   shwAppBar var is true
  *   showAppBar() --> shows the bottom app bar, updates system icon, updates title*/

  _scrollListener() {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (!isScrollingDown) {
        isScrollingDown = true;
        //showBottomAppBar = false;
        _hideAppBar();

        print("hide app bar called");
      }
    }

    if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (isScrollingDown) {
        isScrollingDown = false;
        //showBottomAppBar = true;
        _showAppBar();
        print("show app bar called ");
      }
    }
  }

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    title = title = "Hacker News | ${widget.itemModel.type}";
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> slivers = [
      LayoutAppBarSliver(
        title: title,
        scrollController: scrollController,
      ),
      LayoutTitleSliver(
        title: widget.itemModel.title,
      ),
    ];

    SliverChildListDelegate sliverChildListDelegate = SliverChildListDelegate([
      LayoutBodySliver(
        itemModel: widget.itemModel,
      ),
      CommentsListBuilder(
        numberOfComments: NumberOfComments.subset,
        itemModel: widget.itemModel,
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
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.white,
      bottomNavigationBar: AnimatedCrossFade(
        firstChild: BuildBottomAppBar(
          itemModel: widget.itemModel,
          viewMode: ViewMode.commentView,
        ),
        secondChild: blankWidget(context),
        duration: Duration(milliseconds: 300),
        firstCurve: Curves.fastOutSlowIn,
        secondCurve: Curves.fastOutSlowIn,
        crossFadeState: showBottomAppBar
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
      ),
      body: FadeAnimation(
        duration: Duration(milliseconds: 500),
        child: CustomScrollView(
          controller: scrollController,
          physics: ClampingScrollPhysics(),
          slivers: slivers,
        ),
      ),
    );
  }
}

Widget blankWidget(BuildContext context) {
  return Container(
    color: Colors.transparent,
    height: 00.0,
    width: MediaQuery.of(context).size.width,
  );
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
