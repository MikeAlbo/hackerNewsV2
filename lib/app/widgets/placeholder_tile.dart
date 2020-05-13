import 'package:flutter/material.dart';

class PlaceHolderTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: _buildContainer(height: 25.0, width: 100.0),
      subtitle: _buildContainer(height: 15.0, width: 40.0),
    );
  }
}

Container _buildContainer(
    {@required double height, @required double width, Color color}) {
  final Color containerColor = color != null ? color : Colors.transparent;
  return Container(
    color: containerColor,
    height: height,
    width: width,
  );
}
