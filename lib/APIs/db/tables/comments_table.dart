/*
* Comments table
* function should return the SQL required to create the comments table
* comments table should be identical to items
* */

String buildItemTable() {
  return '''
  CREATE TABLE Comments (
  id INTEGER PRIMARY KEY,
  deleted INTEGER,
  type TEXT,
  by Text,
  time INTEGER,
  text TEXT,
  dead INTEGER,
  parent INTEGER,
  poll INTEGER,
  kids BLOB,
  url TEXT,
  score INTEGER,
  title TEXT,
  parts BLOB,
  descendants INTEGER
  )
  ''';
}
