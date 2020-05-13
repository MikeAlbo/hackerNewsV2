import 'package:flutter/material.dart';

//todo: incorporate theme data

buildHomeAppBar({
  @required String title,
  @required bool centerTitle,
}) {
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
  );
}
