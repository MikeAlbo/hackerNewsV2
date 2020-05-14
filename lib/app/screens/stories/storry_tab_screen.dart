import 'package:flutter/material.dart';
import 'package:hacker_news/APIs/api_helpers.dart';
import 'package:hacker_news/BLOCs/Stories/stories_provider.dart';
import 'package:hacker_news/app/screens/listBuilders/list_view.dart';

class StoryTabScreen extends StatefulWidget {
  final StoriesBloc storiesBloc;
  final IdListName idListName;

  StoryTabScreen({this.storiesBloc, this.idListName});

  @override
  _StoryTabScreenState createState() => _StoryTabScreenState();
}

class _StoryTabScreenState extends State<StoryTabScreen>
    with TickerProviderStateMixin {
  AnimationController fadeController;
  Animation<double> fadeAnimation;

  @override
  void initState() {
    fadeController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    super.initState();

    fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: fadeController,
      curve: Curves.easeIn,
    ));
    fadeController.forward();
  }

  @override
  Widget build(BuildContext context) {
    widget.storiesBloc.fetchSingleList(idListName: widget.idListName);
    widget.storiesBloc.addCurrentListName(idListName: widget.idListName);
    return FadeTransition(
      child: buildListView(storiesBloc: widget.storiesBloc),
      opacity: fadeAnimation,
    );
  }

  @override
  void dispose() {
    fadeController.reverse();
    fadeController.dispose();
    super.dispose();
  }
}
