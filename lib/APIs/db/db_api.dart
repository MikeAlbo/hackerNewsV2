/*
* dbAPI
* the DbApi class handles the connection, create tables, and CRUD methods for the entire app
* */

import 'dart:async';
import 'dart:io';

import 'package:hacker_news/APIs/api_helpers.dart';
import 'package:hacker_news/Models/ids_list.dart';
import 'package:hacker_news/Models/item.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'tables/comments_table.dart';
import 'tables/ids_list_table.dart';
import 'tables/item_table.dart';
import 'tables/user_prefs_table.dart';

var readyCompleter = Completer();
Future get ready => readyCompleter.future;

class DbAPi {
  Database db;

  // database name, UPDATE THIS STRING TO CHANGE DB NAME!
  String dbName =
      "hackerNewsV9"; // add updated field to item and comment tables

  DbAPi() {
    // call the init function to setup DB connection
    init(dbName: dbName).then((_) => readyCompleter.complete());
  }

  // init, setups new DB and establishes connection to new/ existing DB
  Future init({String dbName}) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, dbName);
    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
      newDb.execute(buildItemTable());
      newDb.execute(buildUserPrefsTable());
      newDb.execute(buildIdsListTable());
      print("built Ids List table");
      newDb.execute(buildCommentsTable());
    });
  }

  // fetch a list of IDs from the DB
  Future<IdsListModel> fetchListOfIDs(IdListName listName) async {
    await ready;
    final String name = getListName(listName);
    final String tableName = getTableName(DbTables.listOfIds);
    final query = await db.query(tableName,
        columns: null, where: "listName = ?", whereArgs: [name]);
    print("QUERY: ${query.length}");
    return query.length < 1 ? null : IdsListModel.fromDB(query.first);
  }

  // add a list of IDs to the DB
  Future<int> addListToDb(IdsListModel idsListModel) async {
    await ready;
    final String tableName = getTableName(DbTables.listOfIds);
    print(
        "addListToDbL TABLE NAME: $tableName, LIST NAME ${idsListModel.listName}");
    return await db.insert(tableName, idsListModel.toMapForDB(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // fetch an Item or Comment from the DB
  Future<ItemModel> fetchItem({ItemType itemType, int id}) async {
    await ready;
    final String tableName = getTableName(
        itemType == ItemType.comment ? DbTables.comments : DbTables.item);
    final query = await db
        .query(tableName, columns: null, where: "id = ?", whereArgs: [id]);
    return query.length < 1 ? null : ItemModel.fromDB(query.first);
  }

  // write an Item or Comment to the DB
  Future<int> addItemToDb({ItemType itemType, ItemModel itemModel}) async {
    await ready;
    final String tableName = getTableName(
        itemType == ItemType.comment ? DbTables.comments : DbTables.item);
    return await db.insert(tableName, itemModel.toMapForDB(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // clear comments table
  // clear all items
}
