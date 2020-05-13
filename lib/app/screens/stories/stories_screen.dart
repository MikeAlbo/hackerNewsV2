import 'package:flutter/material.dart';
import 'package:hacker_news/APIs/api_helpers.dart';
import 'package:hacker_news/BLOCs/Stories/stories_provider.dart';
import 'package:hacker_news/app/screens/stories/storry_tab_screen.dart';

class StoriesScreen extends StatefulWidget {
  @override
  _StoriesScreenState createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  @override
  Widget build(BuildContext context) {
    final StoriesBloc _storiesBloc = StoriesProvider.of(context);

    List<Widget> screens = [
      StoryTabScreen(
          storiesBloc: _storiesBloc, idListName: IdListName.topStories),
      StoryTabScreen(
          storiesBloc: _storiesBloc, idListName: IdListName.newStories),
      StoryTabScreen(
          storiesBloc: _storiesBloc, idListName: IdListName.askStories),
      StoryTabScreen(
          storiesBloc: _storiesBloc, idListName: IdListName.jobStories),
      StoryTabScreen(
          storiesBloc: _storiesBloc, idListName: IdListName.showStories),
    ];

    return DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            elevation: 1.0,
            brightness: Brightness.light,
            centerTitle: false,
            title: Text(
              "Stories",
              style: TextStyle(color: Colors.black87),
            ),
            backgroundColor: Colors.white,
            bottom: TabBar(
                unselectedLabelColor: Colors.grey[500],
                labelColor: Colors.black87,
                indicatorColor: Colors.black87,
                indicatorWeight: 1.0,
                tabs: <Widget>[
                  _buildTab(title: "Top"),
                  _buildTab(title: "New"),
                  _buildTab(title: "Ask"),
                  _buildTab(title: "Jobs"),
                  _buildTab(title: "Show"),
                ]),
          ),
          body: TabBarView(
            children: screens,
          ),
        ));
  }
}

Tab _buildTab({@required String title}) {
  return Tab(
    text: title,
  );
}
