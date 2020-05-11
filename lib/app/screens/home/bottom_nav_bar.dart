import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;

  void selectTab(int index) {
    setState(() {
      index = index;
      print(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.white70,
      unselectedItemColor: Colors.grey[500],
      items: [
        buildNavBarItem(icon: Icons.home, title: "Home"),
        buildNavBarItem(icon: Icons.poll, title: "Poll"),
        buildNavBarItem(icon: Icons.question_answer, title: "Ask"),
        buildNavBarItem(icon: Icons.web), // test no text
      ],
      currentIndex: _currentIndex,
      onTap: selectTab,
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
