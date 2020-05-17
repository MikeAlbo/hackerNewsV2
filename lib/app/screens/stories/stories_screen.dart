import 'package:flutter/material.dart';
import 'package:hacker_news/APIs/api_helpers.dart';
import 'package:hacker_news/BLOCs/Stories/stories_provider.dart';
import 'package:hacker_news/Models/user_prefs.dart';
import 'package:hacker_news/app/screens/stories/storry_tab_screen.dart';
import 'package:hacker_news/app/widgets/app_bar.dart';

class StoriesScreen extends StatefulWidget {
  @override
  _StoriesScreenState createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  @override
  Widget build(BuildContext context) {
    final StoriesBloc _storiesBloc = StoriesProvider.of(context);
    _storiesBloc.getUserPrefs();

    List<Widget> filterScreens(UserPrefs userPrefs, StoriesBloc storiesBloc) {
      List<Widget> screens = [];
      if (userPrefs.showNewStories) {
        screens.add(StoryTabScreen(
            storiesBloc: _storiesBloc, idListName: IdListName.newStories));
      }
      if (userPrefs.showTopStories) {
        screens.add(StoryTabScreen(
            storiesBloc: _storiesBloc, idListName: IdListName.topStories));
      }
      if (userPrefs.showAskStories) {
        screens.add(StoryTabScreen(
            storiesBloc: _storiesBloc, idListName: IdListName.askStories));
      }
      if (userPrefs.showJobStories) {
        screens.add(StoryTabScreen(
            storiesBloc: _storiesBloc, idListName: IdListName.jobStories));
      }
      if (userPrefs.showShowStories) {
        screens.add(StoryTabScreen(
            storiesBloc: _storiesBloc, idListName: IdListName.showStories));
      }
      return screens;
    }

    List<Tab> getTabs(UserPrefs userPrefs) {
      List<Tab> tabList = [];
      if (userPrefs.showNewStories) {
        tabList.add(_buildTab(title: "New"));
      }
      if (userPrefs.showTopStories) {
        tabList.add(_buildTab(title: "Top"));
      }
      if (userPrefs.showAskStories) {
        tabList.add(_buildTab(title: "Ask"));
      }
      if (userPrefs.showJobStories) {
        tabList.add(_buildTab(title: "Job"));
      }
      if (userPrefs.showShowStories) {
        tabList.add(_buildTab(title: "Show"));
      }
//  if (userPrefs.showShowStories) {
//    tabList.add(_buildTab(title: "Show"));
//  }

      return tabList;
    }

    return StreamBuilder(
      stream: _storiesBloc.userPrefs,
      builder: (BuildContext ctx, AsyncSnapshot<UserPrefs> snapshot) {
        if (!snapshot.hasData) {
          return Text("No data");
        }

        List<Widget> filteredScreens =
            filterScreens(snapshot.data, _storiesBloc);

        List<Tab> filteredTabs = getTabs(snapshot.data);

        return DefaultTabController(
          length: filteredScreens.length,
          child: Scaffold(
            appBar: buildAppBar(
                title: "Stories",
                centerTitle: false,
                bottom: TabBar(
                  unselectedLabelColor: Colors.grey[500],
                  labelColor: Colors.black87,
                  indicatorColor: Colors.black87,
                  indicatorWeight: 1.0,
                  tabs: filteredTabs,
                )),
            body: TabBarView(
              children: filteredScreens,
            ),
          ),
        );
      },
    );
  }
}

Tab _buildTab({@required String title}) {
  return Tab(
    text: title,
  );
}
