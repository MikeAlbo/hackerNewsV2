import 'package:flutter/material.dart';

class SummaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      color: Colors.green,
      child: Center(
          child: Text(
        "Summary Screen",
        style: TextStyle(fontSize: 40.0),
      )),
    );
  }
}
