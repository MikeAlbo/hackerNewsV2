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
import 'package:hacker_news/Models/item.dart';
import 'package:hacker_news/helpers/date_time.dart';

import '../APIs/db/db_api.dart';

final DbAPi _dbAPi = DbAPi();
final HNFireBaseApi _hnFireBaseApi = HNFireBaseApi();

final Duration listRefreshDuration = Duration(minutes: 10);
final Duration commentRefreshDuration = Duration(minutes: 30);

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
    if (idsList != null &&
        !isExpired(
            duration: listRefreshDuration, timeStamp: idsList.lastUpdated)) {
      return idsList;
    }
    idsList = await _hnFireBaseApi.fetchListOfIds(listName);
    await _dbAPi
        .addListToDb(idsList)
        .catchError((err) => print(err.toString()));
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

  // get a Comment
  Future<ItemModel> getComment(int id) async {
    ItemModel item;
    item = await _dbAPi.fetchItem(itemType: ItemType.comment, id: id);
    if (item != null &&
        !isExpired(
            duration: commentRefreshDuration, timeStamp: item.lastUpdated)) {
      return item;
    }
    item = await _hnFireBaseApi.fetchItem(id);
    _dbAPi.addItemToDb(itemType: ItemType.comment, itemModel: item);
    return item;
  }

  // get an Item
  Future<ItemModel> getItem(int id) async {
    ItemModel item;
    item = await _dbAPi.fetchItem(itemType: ItemType.item, id: id);
    if (item != null) {
      print("Got item from db");
      return item;
    }
    item = await _hnFireBaseApi.fetchItem(id);
    _dbAPi.addItemToDb(itemType: ItemType.item, itemModel: item);
    print("going to APi for item");
    return item;
  }

  // filter cached items for type (may not be needed)
  // clear entire db
  // clear comment data

}

_Repository _repository = _Repository();
_Repository get getRepository => _repository;
