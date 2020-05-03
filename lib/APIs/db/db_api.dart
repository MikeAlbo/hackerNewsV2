/*
* dbAPI
* the DbApi class handles the connection, create tables, and CRUD methods for the entire app
* */

import 'dart:io';

import 'package:hacker_news/APIs/api_helpers.dart';
import 'package:hacker_news/Models/ids_list.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'tables/comments_table.dart';
import 'tables/ids_list_table.dart';
import 'tables/item_table.dart';
import 'tables/user_prefs_table.dart';

class DbAPi {
  Database db;

  // database name, UPDATE THIS STRING TO CHANGE DB NAME!
  String dbName = "hackerNewsV1";

  DbAPi() {
    // call the init function to setup DB connection
    init(dbName: dbName);
  }

  // init, setups new DB and establishes connection to new/ existing DB
  void init({String dbName}) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, dbName);
    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) async {
      await newDb.execute(buildItemTable());
      await newDb.execute(buildUserPrefsTable());
      await newDb.execute(buildIdsListTable());
      await newDb.execute(buildCommentsTable());
    });
  }

  Future<IdsListModel> fetchListOfIDs(IdListName listName) async {
    final query = await db.query(getTableName(DbTables.listOfIds),
        columns: null, where: "listName = ?", whereArgs: getListName(listName));
    return query.length > 0 ? IdsListModel.fromDB(query.first) : null;
  }

  Future<int> addListToDb(IdsListModel idsListModel) {
    return db.insert(
        getTableName(DbTables.listOfIds), idsListModel.toMapForDB(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
