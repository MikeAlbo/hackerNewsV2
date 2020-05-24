import 'package:flutter/material.dart';

Widget buildBottomAppBar() {
  return BottomAppBar(
    color: Colors.grey[100],
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        buildIconButton(icon: Icons.open_in_new, action: () {}),
        buildIconButton(icon: Icons.bookmark_border, action: () {}),
        buildIconButton(icon: Icons.share, action: () {}),
        buildIconButton(icon: Icons.question_answer, action: () {}),
      ],
    ),
  );
}

IconButton buildIconButton({IconData icon, VoidCallback action}) {
  return IconButton(
    icon: Icon(icon),
    onPressed: action,
    color: Colors.grey[600],
  );
}
