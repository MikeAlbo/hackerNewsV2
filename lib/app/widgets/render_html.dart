import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

String renderHtmlBodyText(String text, {bool enableLinks = true}) {
  print(text);
  return Html(
    data: text,
    style: _htmlStyles,
  ).toString();
}

Map<String, Style> _htmlStyles = {
  "*": Style(
      fontSize: FontSize.medium,
      fontWeight: FontWeight.w500,
      textAlign: TextAlign.start,
      whiteSpace: WhiteSpace.PRE,
      wordSpacing: 3.0),
};
