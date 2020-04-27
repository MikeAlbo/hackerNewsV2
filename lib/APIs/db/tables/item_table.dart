/*
* item table
* function should return the SQL required to create the item table
* */

String buildItemTable() {
  return '''
  CREATE TABLE Items (
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
