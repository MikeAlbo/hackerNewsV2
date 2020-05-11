/*
* api helpers
* enums and functions to make accessing the databases and external api
* easier and consistent
* */

//todo: consider moving helpers to the appropriate class files
// enum list of the

enum IdListName {
  topStories,
  bestStories,
  newStories,
  askStories,
  showStories,
  jobStories
}

enum DbTables { comments, listOfIds, item, userPrefs }

enum ItemType { item, comment }

String getTableName(DbTables dbTables) {
  String table = "";
  switch (dbTables) {
    case DbTables.comments:
      table = "Comments";
      break;
    case DbTables.listOfIds:
      table = "IdsList";
      break;
    case DbTables.item:
      table = "Items";
      break;
    case DbTables.userPrefs:
      table = "UserPrefs";
      break;
    // input is ENUM, no default assigned
  }

  return table;
}

String getStoriesList(IdListName listName) {
  String list = "";
  switch (listName) {
    case IdListName.topStories:
      list = "topStories";
      break;
    case IdListName.bestStories:
      list = "bestStories";
      break;
    case IdListName.newStories:
      list = "newStories";
      break;
    case IdListName.askStories:
      list = "askStories";
      break;
    case IdListName.showStories:
      list = "showStories";
      break;
    case IdListName.jobStories:
      list = "jobStories";
      break;
    default:
      list = null;
  }
  return list;
}

String apiEndpointsInLowerCase(IdListName idListName) {
  return getStoriesList(idListName).toLowerCase();
}

Function(IdListName) get getApiEndPoint => apiEndpointsInLowerCase;
Function(IdListName) get getListName => getStoriesList;
