import 'package:flutter/material.dart';

//todo: incorporate theme data

AppBar buildHomeAppBar({@required String title, @required bool isMainTitle}) {
  return AppBar(
    elevation: 1.0,
    title: Text(
      title,
      style: TextStyle(color: Colors.black87),
    ),
    centerTitle: isMainTitle ? true : false,
    backgroundColor: Colors.white,
    actions: [
      IconButton(
        icon: Icon(Icons.settings),
        color: Colors.black87,
        onPressed: () {},
      )
    ],
  );
}
