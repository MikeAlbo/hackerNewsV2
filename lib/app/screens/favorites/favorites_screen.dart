import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      color: Colors.red,
      child: Center(
          child: Text(
        "Favorites Screen",
        style: TextStyle(fontSize: 40.0),
      )),
    );
  }
}
