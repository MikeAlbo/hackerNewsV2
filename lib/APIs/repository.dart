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
import 'package:hacker_news/helpers/date_time.dart';

import '../APIs/db/db_api.dart';

final DbAPi _dbAPi = DbAPi();
final HNFireBaseApi _hnFireBaseApi = HNFireBaseApi();

final Duration listRefreshDuration = Duration(minutes: 30);

class Repository {
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
    if (idsList != null &&
        !isExpired(
            duration: listRefreshDuration, timeStamp: idsList.lastUpdated)) {
      return idsList;
    }
    idsList = await _hnFireBaseApi.fetchListOfIds(listName);
    _dbAPi.addListToDb(idsList);
    return idsList;
  }

  Future<Map<String, IdsListModel>> getAllListOfIds() async {
    Map<String, IdsListModel> results;
    IdListName.values.forEach((name) async {
      final String listName = getListName(name);
      results[listName] = await getListOfIds(name);
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
