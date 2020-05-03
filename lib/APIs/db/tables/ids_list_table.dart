/*
* ids list table
* function should return the SQL required to create the user_prefs table
* */

String buildIdsListTable() {
  return """
  CREATE TABLE IdsList (
    listName Text PRIMARY KEY,
    storyIdsList BLOB,
    lastUpdated INTEGER 
  )
  """;
}
