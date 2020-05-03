/*
* repository
* the repo handles the incoming request from the app
* the repo handles ALL api calls to the DB and HN Firebase API
* the repo then returns all data, properly formatted back to the app
* */

import 'dart:async';

import 'package:hacker_news/APIs/api_helpers.dart';
import 'package:hacker_news/APIs/hn_firebase_api.dart';
import 'package:hacker_news/Models/ids_list.dart';

import '../APIs/db/db_api.dart';

final DbAPi _dbAPi = DbAPi();
final HNFireBaseApi _hnFireBaseApi = HNFireBaseApi();

final Duration listRefreshDuration = Duration(minutes: 30);

class _Repository {
  /// returns a single list
  ///
  /// check to see if list exist in IdsList table
  /// if so, check expiration
  /// if expired or returns null, pass through, else return list
  /// fetch new list from api
  /// replace/ add to table
  /// return list
  Future<IdsListModel> getListOfIds(IdListName listName) async {
    IdsListModel idsList;
    idsList = await _dbAPi.fetchListOfIDs(listName);
    if (idsList != null) {
      print("--- DB IDS LIST IS NOT NULL FROM DB AND NOT EXPIRED");
      return idsList;
    }
    print("IDS LIST WAS NULL --  FETCHING FROM DB");
    IdsListModel newIdsList = await _hnFireBaseApi.fetchListOfIds(listName);
    await _dbAPi
        .addListToDb(newIdsList)
        .then((value) => print("add complete!!!"))
        .catchError((err) => print(err.toString()));

    idsList = await _dbAPi.fetchListOfIDs(listName);

    if (idsList == null) {
      print("Ids list is still NULL!! ---");
    }

    return idsList;
  }

  Future<Map<String, IdsListModel>> getAllListOfIds() async {
    Map<String, IdsListModel> results = {};
    await Future.forEach(IdListName.values, (name) async {
      final String listName = getListName(name);
      final IdsListModel model = await getListOfIds(name);
      results[listName] = model;
    });
    return results;
  }

  // retrieve an item from db
  // retrieve an item from HN
  // write a new item to DB
  // filter cached items for type (may not be needed)
  // clear entire db
  // clear comment data

  /*
  * there needs to be a separate comments table that can be cleared independently
  * of the regular items table. When an item is fetched, the "Type" should be checked
  * and == comment, then stored separately. Comments should be retrieved separately
  * using it's own method call and BLOC
  *  */

}

_Repository _repository = _Repository();
_Repository get getRepository => _repository;
