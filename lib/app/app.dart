import 'package:flutter/material.dart';
import 'package:hacker_news/BLOCs/Items/items_provider.dart';
import 'package:hacker_news/BLOCs/Stories/stories_provider.dart';
import 'package:hacker_news/app/screens/home/home.dart';

class HackerNewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: ItemsProvider(
        child: MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );
  }
}
