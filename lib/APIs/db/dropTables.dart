//todo: REMOVE BEFORE PRODUCTION, USED TO TEST TABLE CREATE AND ADDING DATA

import '../api_helpers.dart';

dropTables(String tableName) {
  if (tableName != null) {
    return "DROP TABLE $tableName";
  }
  DbTables.values.forEach((element) {
    String name = getTableName(element);
    return "DROP TABLE $name";
  });
}
