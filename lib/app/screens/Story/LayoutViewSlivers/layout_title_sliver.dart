import 'dart:math' as math;

import 'package:flutter/material.dart';

class LayoutTitleSliver extends StatefulWidget {
  final String title;
  LayoutTitleSliver({this.title});

  @override
  _LayoutTitleSliverState createState() => _LayoutTitleSliverState();
}

class _LayoutTitleSliverState extends State<LayoutTitleSliver> {
  GlobalKey _titleTextKey = GlobalKey();

  double titleHeight = 200;

  _getHeight() {
    final RenderBox textRenderBox =
        _titleTextKey.currentContext.findRenderObject();
    final textSize = textRenderBox.size;
    print("text height: ${textSize.height}");
    setState(() {
      titleHeight = textSize.height;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getHeight();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      floating: false,
      pinned: false,
      delegate: _SliverPersistentHeaderDelegate(
        minHeight: titleHeight + 50.0,
        maxHeight: titleHeight + 50.0,
        child: Card(
          margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.fromLTRB(25.0, 0.0, 15.0, 0.0),
            child: Center(
              child: SelectableText(
                //todo: implement selectable text
                widget.title,
                key: _titleTextKey,
                style: Theme.of(context).textTheme.headline4,
                //style: TextStyle(fontSize: 30.0), //todo -- scale text on scroll
                textAlign: TextAlign.start,
                //overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverPersistentHeaderDelegate({this.child, this.maxHeight, this.minHeight});

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
