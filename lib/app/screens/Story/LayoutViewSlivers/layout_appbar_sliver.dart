import 'package:flutter/material.dart';

class LayoutAppBarSliver extends StatelessWidget {
  final String title;

  LayoutAppBarSliver({this.title});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      brightness: Brightness.light,
      title: Text(
        "Hacker News  |  $title",
        style: TextStyle(color: Colors.black87),
      ),
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black87),
    );
  }
}
