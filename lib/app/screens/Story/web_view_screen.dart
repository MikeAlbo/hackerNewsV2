import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hacker_news/BLOCs/Favorites/favorites_bloc.dart';
import 'package:hacker_news/Models/item.dart';
import 'package:hacker_news/app/screens/Story/bottom_app_bar.dart';
import 'package:hacker_news/app/widgets/app_bar.dart';
import 'package:hacker_news/app/widgets/fade_animation.dart';
import 'package:webview_flutter/webview_flutter.dart';

//todo: implement an oncomplete action
//todo: loading animation
//todo: handle secure site connections
//todo: link follow button
//todo: handle comments transition

class WebViewScreen extends StatefulWidget {
  final ItemModel itemModel;
  final FavoritesBloc favoritesBloc;

  WebViewScreen({this.itemModel, this.favoritesBloc});
  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool errorLoading = false;
  bool isFavorite = false;
  Completer<WebViewController> _webViewController =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    isFavorite =
        widget.favoritesBloc.doesIdExistInFavorites(widget.itemModel.id);

    _updateFavorites() {
      print("_updateFavorite called");
      widget.favoritesBloc.updateItemInFavorites(widget.itemModel.id);
      setState(() {});
    }

    _setErrorLoading() {
      errorLoading = true;
      setState(() {
        print(errorLoading);
      });
    }

    return Scaffold(
      bottomNavigationBar: buildBottomAppBar(
          context: context,
          itemModel: widget.itemModel,
          isFavorite: isFavorite,
          updateFavorites: _updateFavorites),
      appBar: buildAppBar(title: widget.itemModel.title, centerTitle: true),
      body: errorLoading
          ? _errorLoadingPage()
          : Builder(
              builder: (BuildContext context) {
                return WebView(
                  initialUrl: "${widget.itemModel.url}",
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _webViewController.complete(webViewController);
                  },
                  onWebResourceError: (err) {
                    print(err.errorCode);
                    return _setErrorLoading();
                  },
                );
              },
            ),
    );
  }
}

// handle errors when loading sites, todo: implement a link follower option to open in browser
Widget _errorLoadingPage() {
  return FadeAnimation(
    duration: Duration(milliseconds: 500),
    child: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.grey[700],
        child: Center(
            child: Text(
          "Error Loading the site",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ))),
  );
}

testFunction() {
  return print("this is just a test");
}
