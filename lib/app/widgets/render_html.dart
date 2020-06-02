import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

Widget renderHtmlBodyText(String text, {bool enableLinks = true}) {
  return Html(
    data: text,
    style: _htmlStyles,
    onLinkTap: (url) {
      print(url);
    },
  );
}

Map<String, Style> _htmlStyles = {
  "*": Style.fromTextStyle(TextStyle(fontSize: 22.0)),
};
