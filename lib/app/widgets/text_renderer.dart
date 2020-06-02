//import 'package:flutter/material.dart';
//import 'package:hacker_news/app/screens/helpers.dart';
//import 'package:html/dom.dart';
//import 'package:html/parser.dart' show parse;
//
//class TextRenderer extends StatelessWidget {
//  final String text;
//  TextRenderer({this.text});
//  @override
//  Widget build(BuildContext context) {
//    // print(parse(text).body.querySelectorAll("a")[1].innerHtml);
//    //print(parse(text).body.innerHtml);
//    //print(parse(text).body.text);
//
//    List<InlineSpan> elements = [];
//    Document parsedHTML = parse(text);
//    String rawBodyText = parsedHTML.body.text;
//    String results;
//    List nodes = parsedHTML.body.querySelectorAll("a");
//    //print(nodes[1].text);
////    nodes.forEach((node) {
////      print(node.text);
////      String replacedText = trimUrl(node.text);
////      print(replacedText);
////      results = rawBodyText.replaceAll(node.text, trimUrl(node.text));
////    });
//
//    filterText(String text, List nodes) {
//      String results;
//      nodes.forEach((element) {
//        String element = '${element.text}';
//        results = text.replaceAll(new RegExp(r'}'), trimUrl(element.text));
//      });
//      print(results);
//    }
//
//    filterText(parsedHTML.body.text, nodes);
//
//    print(results);
//
//    elements.add(TextSpan(text: parsedHTML.body.text));
////    parsedHTML.body.children.forEach((element) {
////      elements.add(TextSpan(text: element.innerHtml));
////    });
////
//////    parse(text).body.nodes.forEach((element) {
//////      elements.add(element.nodeType);
//////    });
////
////    print("\n\n ------------------------ \n\n");
////    elements.forEach((element) {
////      print("-- $element");
////    });
//
//    return SelectableText.rich(TextSpan(
//      children: elements,
//      style: TextStyle(
//        fontSize: 18.0,
//        fontWeight: FontWeight.w500,
//        height: 2.0,
//      ),
//    ));
//  }
//}
