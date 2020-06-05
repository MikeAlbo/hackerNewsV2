import 'package:flutter/material.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

enum TextType {
  body,
  comment,
  subtitle,
  title,
  message,
  sectionHeader,
  tileBody,
  htmlWithLinks
} //todo: handle html with links

class TextRenderer extends StatelessWidget {
  final String text;
  final TextType textType;
  final bool isSelectable;

  TextRenderer({this.text, this.textType, this.isSelectable = false});

  @override
  Widget build(BuildContext context) {
    Document parsedHTML = parse(text);
    String rawBodyText = parsedHTML.body.text;
    TextSpan renderedText;

    switch (textType) {
      case TextType.body:
        renderedText = _buildTextSpan(rawBodyText, context, _bodyTextStyles);
        break;
    }

//    if(!isSelectable){
//      return RichText(rend)
//    }
    return SelectableText.rich(renderedText);
  }
}

TextSpan _buildTextSpan(
    String rawBodyText, BuildContext context, TextStyle textStyle) {
  return TextSpan(text: rawBodyText, style: textStyle);
}

Map<String, dynamic> defaultStyle = {
  "fontColor": Colors.black,
};

TextStyle _bodyTextStyles = TextStyle(
    color: defaultStyle["fontColor"],
    height: 1.5,
    fontWeight: FontWeight.w500,
    fontSize: 22.0);
