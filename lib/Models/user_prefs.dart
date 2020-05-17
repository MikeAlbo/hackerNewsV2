/*
  UserPrefs model
  UserPrefs will store the user's favorites, last updated time, and categoryShow prefs
 */

import 'dart:convert';

class UserPrefs {
  int userId; // default user ID use as primary key in DB
  int lastUpdated;
  bool showNewStories;
  bool showTopStories;
  bool showBestStories;
  bool showJobStories;
  bool showShowStories;
  bool showAskStories;
  List<dynamic> favorites;

  UserPrefs(
      {this.userId = 1,
      this.lastUpdated,
      this.showNewStories,
      this.showTopStories,
      this.showBestStories,
      this.showJobStories,
      this.showShowStories,
      this.showAskStories,
      this.favorites});

  UserPrefs.fromDB(Map<String, dynamic> parsedDB)
      : lastUpdated = parsedDB["lastUpdated"],
        userId = parsedDB["userId"],
        showNewStories = parsedDB["showNewStories"] == 1,
        showTopStories = parsedDB['showTopStories'] == 1,
        showBestStories = parsedDB['showBestStories'] == 1,
        showJobStories = parsedDB['showJobStories'] == 1,
        showShowStories = parsedDB['showShowStories'] == 1,
        showAskStories = parsedDB['showAskStories'] == 1,
        favorites = jsonDecode(parsedDB['favorites']) ??
            []; // may need to get rid of null check

  Map<String, dynamic> mapUserPrefsForDB() {
    return <String, dynamic>{
      "userId": userId,
      "lastUpdated": lastUpdated,
      "showNewStories": showNewStories ? 1 : 0,
      "showTopStories": showTopStories ? 1 : 0,
      "ShowBestStories": showBestStories ? 1 : 0,
      "ShowJobStories": showJobStories ? 1 : 0,
      "showShowStories": showShowStories ? 1 : 0,
      "ShowAskStories": showAskStories ? 1 : 0,
      "favorites": jsonEncode(favorites)
    };
  }
}
