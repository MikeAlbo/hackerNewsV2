import 'package:flutter/material.dart';

class StoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      color: Colors.blue,
      child: Center(
          child: Text(
        "Stories Screen",
        style: TextStyle(fontSize: 40.0),
      )),
    );
  }
}
