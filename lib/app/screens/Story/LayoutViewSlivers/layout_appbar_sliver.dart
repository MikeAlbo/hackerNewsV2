import 'package:flutter/material.dart';

class LayoutAppBarSliver extends StatelessWidget {
  final String title;

  LayoutAppBarSliver({this.title});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: false,
      elevation: 0.0,
      brightness: Brightness.light,
      title: Text(
        "Hacker News | $title",
        style: TextStyle(color: Colors.black87),
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black87),
    );
  }
}
