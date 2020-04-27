/*
  UserPrefs model
  UserPrefs will store the user's favorites, last updated time, and categoryShow prefs
 */

import 'dart:convert';

class UserPrefs {
  final int userId = 1; // default user ID use as primary key in DB
  final int lastUpdated;
  final bool showJobs;
  final bool showPolls;
  final bool showStory;
  final bool showAsk;
  final List<dynamic> favorites;

  UserPrefs.fromDB(Map<String, dynamic> parsedDB)
      : lastUpdated = parsedDB["lastUpdated"],
        showJobs = parsedDB["showJobs"] == 1,
        showPolls = parsedDB['showPolls'] == 1,
        showStory = parsedDB['showStory'] == 1,
        showAsk = parsedDB['showAsk'] == 1,
        favorites = jsonDecode(parsedDB['favorites']) ??
            []; // may need to get rid of null check

  Map<String, dynamic> mapUserPrefsForDB() {
    return <String, dynamic>{
      "lastUpdated": lastUpdated,
      "showJobs": showJobs ? 1 : 0,
      "showPolls": showPolls ? 1 : 0,
      "showStory": showStory ? 1 : 0,
      "showAsk": showAsk ? 1 : 0,
      "favorites": jsonEncode(favorites)
    };
  }
}
