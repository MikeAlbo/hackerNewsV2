import 'package:flutter/material.dart';
import 'package:hacker_news/APIs/api_helpers.dart';
import 'package:hacker_news/BLOCs/Items/items_provider.dart';
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
  String title = "Hacker News";
  bool centerTitle = true;

  void selectTab(int newIndex) {
    setState(() {
      _currentIndex = newIndex;
      updateHeading(newIndex);
    });
  }

  void updateHeading(int index) {
    switch (index) {
      case 0:
        title = "Hacker News";
        centerTitle = true;
        break;
      case 1:
        title = "Stories";
        centerTitle = false;

        break;
      case 2:
        title = "Favorites";
        centerTitle = false;

        break;
      default:
        title = "Settings";
        centerTitle = false;

        break;
    }
  }

  List<Widget> screens = [
    Expanded(
      child: Container(
        color: Colors.red,
      ),
    ),
    Expanded(
      child: Container(
        color: Colors.green,
      ),
    ),
    Expanded(
      child: Container(
        color: Colors.blue,
      ),
    ),
    Expanded(
      child: Container(
        color: Colors.yellow,
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    final ItemsBloc itemsBloc = ItemsProvider.of(context);
    final StoriesBloc storiesBloc = StoriesProvider.of(context);
    storiesBloc.fetchSingleList(idListName: IdListName.topStories);
    return Scaffold(
      appBar: buildHomeAppBar(title: title, centerTitle: centerTitle),
      body: buildListView(storiesBloc: storiesBloc),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white70,
        unselectedItemColor: Colors.grey[600],
        currentIndex: _currentIndex,
        onTap: selectTab,
        items: [
          buildNavBarItem(icon: Icons.home, title: "Home"),
          buildNavBarItem(icon: Icons.library_books, title: "Stories"),
          buildNavBarItem(icon: Icons.bookmark_border, title: "Saved"),
          buildNavBarItem(
              icon: Icons.person_outline, title: "Settings"), // test no text
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
