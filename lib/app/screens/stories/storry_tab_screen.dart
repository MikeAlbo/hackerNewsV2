import 'package:flutter/material.dart';
import 'package:hacker_news/APIs/api_helpers.dart';
import 'package:hacker_news/BLOCs/Stories/stories_provider.dart';
import 'package:hacker_news/app/screens/listBuilders/list_view.dart';

class StoryTabScreen extends StatelessWidget {
  final StoriesBloc storiesBloc;
  final IdListName idListName;

  StoryTabScreen({this.storiesBloc, this.idListName});
  @override
  Widget build(BuildContext context) {
    storiesBloc.fetchSingleList(idListName: idListName);
    return buildListView(storiesBloc: storiesBloc);
  }
}
