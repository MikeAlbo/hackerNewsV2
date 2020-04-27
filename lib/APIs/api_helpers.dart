/*
* api helpers
* enums and functions to make accessing the databases and external api
* easier and consistent
* */

// enum list of the
enum IdListType {
  topStories,
  bestStories,
  newStories,
  askStories,
  showStories,
  jobStories
}

String _getStoriesList(IdListType listType) {
  String list = "";
  switch (listType) {
    case IdListType.topStories:
      list = "topStories";
      break;
    case IdListType.bestStories:
      list = "bestStories";
      break;
    case IdListType.newStories:
      list = "newStories";
      break;
    case IdListType.askStories:
      list = "askStories";
      break;
    case IdListType.showStories:
      list = "showStories";
      break;
    case IdListType.jobStories:
      list = "jobStories";
      break;
    default:
      list = null;
  }
  return list;
}

Function(IdListType) get getApiEndPoint => _getStoriesList;
Function(IdListType) get getListName => _getStoriesList;
