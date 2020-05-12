import 'package:flutter/material.dart';
import 'package:hacker_news/APIs/api_helpers.dart';
import 'package:hacker_news/BLOCs/Items/items_bloc.dart';
import 'package:hacker_news/BLOCs/Items/items_provider.dart';
import 'package:hacker_news/BLOCs/Stories/stories_bloc.dart';
import 'package:hacker_news/BLOCs/Stories/stories_provider.dart';
import 'package:hacker_news/app/widgets/list_view.dart';

import 'app_bar.dart';

// todo: will need to pass the block through to dependants for their actions to work

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void selectTab(int newIndex) {
    setState(() {
      _currentIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ItemsBloc itemsBloc = ItemsProvider.of(context);
    final StoriesBloc storiesBloc = StoriesProvider.of(context);
    storiesBloc.fetchSingleList(idListName: IdListName.topStories);
    return Scaffold(
      appBar: buildHomeAppBar(title: "Hacker News"),
      body: buildListView(storiesBloc: storiesBloc, itemsBloc: itemsBloc),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white70,
        unselectedItemColor: Colors.grey[600],
        currentIndex: _currentIndex,
        onTap: selectTab,
        items: [
          buildNavBarItem(icon: Icons.home, title: "Home"),
          buildNavBarItem(icon: Icons.poll, title: "Poll"),
          buildNavBarItem(icon: Icons.question_answer, title: "Ask"),
          buildNavBarItem(icon: Icons.web, title: "Show"), // test no text
        ],
      ),
    );
  }
}

// builder for the NavBar tab
BottomNavigationBarItem buildNavBarItem(
    {@required IconData icon, String title}) {
  return BottomNavigationBarItem(
    backgroundColor: Colors.black87,
    icon: Icon(icon),
    title: Text(title ?? ""),
  );
}
