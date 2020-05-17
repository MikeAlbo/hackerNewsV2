/*
* user prefs table
* function should return the SQL required to create the user_prefs table
* */

String buildUserPrefsTable() {
  return """
  CREATE TABLE UserPrefs (
    lastUpdated INTEGER,
    showNewStories INTEGER,
    showTopStories INTEGER,
    showBestStories INTEGER,
    showJobStories INTEGER,
    showShowStories INTEGER,
    showAskStories INTEGER,
    favorites BLOB,
    userId INTEGER PRIMARY KEY
  )
  """;
}
