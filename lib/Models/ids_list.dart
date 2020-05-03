/*
IdsListModel
the IdsListModel caches the different list returned from the API calls
these list include topStories, bestStories, newStories, askStories, showStories, and jobStories
 */
import 'dart:convert';

class IdsListModel {
  final String listName;
  final int lastUpdated;
  final List<dynamic> storyIdsList;

  IdsListModel.fromJSON(Map<String, dynamic> parsedJSON)
      : listName = parsedJSON['listName'],
        lastUpdated = parsedJSON['lastUpdated'] ?? 0, // test
        storyIdsList = parsedJSON['storyIdsList'];

  IdsListModel.fromDB(Map<String, dynamic> parsedDB)
      : listName = parsedDB['listName'],
        lastUpdated = parsedDB['lastUpdated'],
        storyIdsList = jsonDecode(parsedDB['storyIdsList']);

  Map<String, dynamic> toMapForDB() {
    return <String, dynamic>{
      "listName": listName,
      "lastUpdated": lastUpdated,
      "storyIdsList": jsonEncode(storyIdsList)
    };
  }
}
