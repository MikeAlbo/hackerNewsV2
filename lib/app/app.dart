import 'package:flutter/material.dart';
import 'package:hacker_news/BLOCs/Comments/comments_provider.dart';
import 'package:hacker_news/BLOCs/Favorites/favorites_provider.dart';
import 'package:hacker_news/BLOCs/Items/items_provider.dart';
import 'package:hacker_news/BLOCs/Stories/stories_provider.dart';
import 'package:hacker_news/app/routes.dart';

class HackerNewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FavoritesProvider(
      child: CommentsProvider(
        child: StoriesProvider(
          child: ItemsProvider(
            child: MaterialApp(
              title: "Hacker News",
              initialRoute: "/",
              onGenerateRoute: _routes,
            ),
          ),
        ),
      ),
    );
  }
}

Route _routes(RouteSettings routeSettings) {
  print("---->>> route name: ${routeSettings.name}"); //todo: remove print!
  switch (routeSettings.name) {
    case "/":
      return getHomeScreenRoute(settings: routeSettings);
      break;
    case "/story":
      return getStoryScreenRoute(settings: routeSettings);
      break;
    default:
      return getHomeScreenRoute(settings: routeSettings);
  }
}
