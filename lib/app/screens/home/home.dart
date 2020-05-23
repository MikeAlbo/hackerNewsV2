import 'package:flutter/material.dart';
import 'package:hacker_news/app/screens/favorites/favorites_screen.dart';
import 'package:hacker_news/app/screens/profile/profile_screen.dart';
import 'package:hacker_news/app/screens/stories/stories_screen.dart';
import 'package:hacker_news/app/screens/summary/summary_screen.dart';

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

  List<Widget> screens = [
    SummaryScreen(),
    StoriesScreen(),
    FavoritesScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: buildHomeAppBar(title: title, centerTitle: centerTitle),
      //body: buildListView(storiesBloc: storiesBloc),
      body: screens.elementAt(_currentIndex),
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
