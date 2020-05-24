import 'package:flutter/material.dart';

//todo: incorporate theme data

buildAppBar(
    {@required String title,
    @required bool centerTitle,
    PreferredSizeWidget bottom,
    List<Widget> actions}) {
  return AppBar(
    elevation: 1.0,
    title: Text(
      title,
      style: TextStyle(
        color: Colors.black87,
      ),
    ),
    centerTitle: centerTitle ? true : false,
    backgroundColor: Colors.white,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black87),
    bottom: bottom,
    actions: actions,
  );
}
