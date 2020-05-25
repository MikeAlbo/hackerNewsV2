import 'dart:math' as math;

import 'package:flutter/material.dart';

class LayoutTitleSliver extends StatelessWidget {
  final String title;
  LayoutTitleSliver({this.title});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverPersistentHeaderDelegate(
          minHeight: 100.0,
          maxHeight: 200.0,
          child: Container(
            padding: EdgeInsets.only(top: 40.0),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      title,
                      //style: TextStyle(fontSize: 30.0), //todo -- scale text on scroll
                      textAlign: TextAlign.center,
                      //overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          )),
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
