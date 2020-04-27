/*
* user prefs table
* function should return the SQL required to create the user_prefs table
* */

String buildUserPrefsTable() {
  return """
  CREATE TABLE UserPrefs (
    lastUpdated INTEGER,
    showJobs INTEGER,
    showPolls INTEGER,
    showStory INTEGER,
    showAsk INTEGER,
    favorites BLOB,
    userId INTEGER PRIMARY KEY
  )
  """;
}
