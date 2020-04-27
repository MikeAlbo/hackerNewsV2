/*
IdsListModel
the IdsListModel caches the different list returned from the API calls
these list include topStories, bestStories, newStories, askStories, showStories, and jobStories
 */
import 'dart:convert';

enum IdListType {
  topStories,
  bestStories,
  newStories,
  askStories,
  showStories,
  jobStories
}

class IdsListModel {
  final String listName;
  final int lastUpdated;
  final List<int> storyIdsList;

  IdsListModel.fromJSON(Map<String, dynamic> parsedJSON)
      : listName = parsedJSON['listName'],
        lastUpdated = parsedJSON['lastUpdated'],
        storyIdsList = parsedJSON['topStories'];

  IdsListModel.fromDB(Map<String, dynamic> parsedDB)
      : listName = parsedDB['listName'],
        lastUpdated = parsedDB['lastUpdated'],
        storyIdsList = jsonDecode(parsedDB['topStories']);

  Map<String, dynamic> toMapForDB() {
    return <String, dynamic>{
      "listName": listName,
      "lastUpdated": lastUpdated,
      "topStories": jsonEncode(storyIdsList)
    };
  }
}
