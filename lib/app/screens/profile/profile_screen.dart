import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      constraints: BoxConstraints.expand(),
      child: Center(
          child: Text(
        "Profile Screen",
        style: TextStyle(fontSize: 40.0),
      )),
    );
  }
}
