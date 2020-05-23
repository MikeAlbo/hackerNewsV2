import 'package:flutter/material.dart';
import 'package:hacker_news/BLOCs/Favorites/favorites_provider.dart';
import 'package:hacker_news/BLOCs/Stories/stories_provider.dart';
import 'package:hacker_news/app/screens/home/home.dart';

// HomeScreen route
Route getHomeScreenRoute({RouteSettings settings}) {
  return MaterialPageRoute(builder: (BuildContext ctx) {
    final StoriesBloc storiesBloc = StoriesProvider.of(ctx);
    storiesBloc.initUserPrefs();
    final FavoritesBloc favoritesBloc = FavoritesProvider.of(ctx);
    favoritesBloc.preloadUserPrefs;
    return HomeScreen();
  });
}
