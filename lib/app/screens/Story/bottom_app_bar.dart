import 'package:flutter/material.dart';
import 'package:hacker_news/BLOCs/Favorites/favorites_bloc.dart';
import 'package:hacker_news/BLOCs/Favorites/favorites_provider.dart';
import 'package:hacker_news/Models/item.dart';
import 'package:hacker_news/app/screens/Story/web_view_screen.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'layout_view_screen.dart';

enum ViewMode { commentView, webView }

class BuildBottomAppBar extends StatefulWidget {
  final ItemModel itemModel;
  final ViewMode viewMode;

  BuildBottomAppBar({this.itemModel, this.viewMode});

  @override
  _BuildBottomAppBarState createState() => _BuildBottomAppBarState();
}

class _BuildBottomAppBarState extends State<BuildBottomAppBar> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    FavoritesBloc favoritesBloc = FavoritesProvider.of(context);
    _isFavorite = favoritesBloc.doesIdExistInFavorites(widget.itemModel.id);

    _updateFavorites() {
      print("_updateFavorite called");
      favoritesBloc.updateItemInFavorites(widget.itemModel.id);
      setState(() {});
    }

    _updateIsFavorite() {
      setState(() {
        _isFavorite = favoritesBloc.doesIdExistInFavorites(widget.itemModel.id);
      });
    }

    _launchUrl() async {
      String link = widget.itemModel.url == ""
          ? "https://news.ycombinator.com/item?id=${widget.itemModel.id}"
          : widget.itemModel.url;
      if (await canLaunch(link)) {
        await launch(link, enableJavaScript: true).then((value) {
          _updateIsFavorite();
        });
      } else {
        throw 'Could not launch $link';
      }
    }

    _shareStory() {
      String link = widget.itemModel.url == ""
          ? "https://news.ycombinator.com/item?id=${widget.itemModel.id}"
          : widget.itemModel.url;
      String subject = "${widget.itemModel.title} -- from the HN App";
      final RenderBox box = context.findRenderObject();
      return Share.share(link,
          subject: subject,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }

    _navToComments() {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return LayoutViewScreen(
          itemModel: widget.itemModel,
        );
      })).then((value) {
        _updateIsFavorite();
      });
    }

    _navToWebView() {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return WebViewScreen(
          itemModel: widget.itemModel,
        );
      })).then((value) {
        _updateIsFavorite();
      });
    }

    return BottomAppBar(
      color: Colors.grey[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildIconButton(icon: Icons.open_in_new, action: () => _launchUrl()),
          buildIconButton(
              icon: _isFavorite ? Icons.bookmark : Icons.bookmark_border,
              action: () => _updateFavorites(),
              favorite: _isFavorite),
          buildIconButton(
            icon: Icons.share,
            action: () => _shareStory(),
          ),
          widget.viewMode == ViewMode.webView
              ? buildIconButton(
                  icon: Icons.question_answer, action: () => _navToComments())
              : buildIconButton(
                  noUrl: widget.itemModel.url == "",
                  icon: Icons.open_in_browser,
                  action: () => _navToWebView()),
        ],
      ),
    );
  }
}

IconButton buildIconButton(
    {IconData icon,
    Function action,
    bool favorite = false,
    bool noUrl = false}) {
  return IconButton(
    icon: Icon(icon),
    onPressed: noUrl ? null : action,
    color: favorite ? Colors.redAccent : Colors.grey[600],
  );
}
