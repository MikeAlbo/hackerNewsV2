import 'package:flutter/material.dart';

//todo: incorporate theme data

AppBar buildHomeAppBar({@required String title}) {
  return AppBar(
    elevation: 1.0,
    title: Text(
      title,
      style: TextStyle(color: Colors.black87),
    ),
    centerTitle: true,
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
