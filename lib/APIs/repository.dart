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
import 'package:hacker_news/Models/user_prefs.dart';
import 'package:hacker_news/helpers/date_time.dart';

import '../APIs/db/db_api.dart';

export 'api_helpers.dart';

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
      return item;
    }
    item = await _hnFireBaseApi.fetchItem(id);
    _dbAPi.addItemToDb(itemType: ItemType.item, itemModel: item);
    return item;
  }

  // filter cached items for type (may not be needed)
  // clear entire db
  // clear comment data

// init the user prefs
  Future<int> initUserPrefs() async {
    UserPrefs userPrefs = await _dbAPi.fetchUserPrefs();
    if (userPrefs == null) {
      UserPrefs userPrefs = UserPrefs(
          showJobStories: true,
          showNewStories: true,
          showTopStories: true,
          showBestStories: true,
          showAskStories: true,
          showShowStories: true,
          lastUpdated: timeNowInMilliseconds(),
          favorites: []);
      return await _dbAPi.updateUserPrefs(userPrefs: userPrefs);
    }
    return null;
  }

// get userPrefs
  Future<UserPrefs> getUserPrefs() async {
    return await _dbAPi.fetchUserPrefs();
  }

// update lastUpdated field
  Future<UserPrefs> updateLastUpdatedField(
      {bool returnUpdatedPrefs = true}) async {
    UserPrefs oldUserPrefs = await getUserPrefs();
    UserPrefs newUserPrefs = oldUserPrefs;
    newUserPrefs.lastUpdated = timeNowInMilliseconds();
    await _dbAPi.updateUserPrefs(userPrefs: newUserPrefs);
    return returnUpdatedPrefs ? await _dbAPi.fetchUserPrefs() : null;
  }

// update a prefs bool
  Future<UserPrefs> updateShowListBool(
      {IdListName idListName, bool returnUpdatedPrefs = true}) async {
    UserPrefs oldUserPrefs = await getUserPrefs();
    switch (idListName) {
      case IdListName.topStories:
        oldUserPrefs.showTopStories = !oldUserPrefs.showTopStories;
        break;
      case IdListName.bestStories:
        oldUserPrefs.showBestStories = !oldUserPrefs.showBestStories;
        break;
      case IdListName.newStories:
        oldUserPrefs.showNewStories = !oldUserPrefs.showNewStories;
        break;
      case IdListName.jobStories:
        oldUserPrefs.showJobStories = !oldUserPrefs.showJobStories;
        break;
      case IdListName.showStories:
        oldUserPrefs.showShowStories = !oldUserPrefs.showShowStories;
        break;
      case IdListName.askStories:
        oldUserPrefs.showAskStories = !oldUserPrefs.showAskStories;
        break;
    }
    await _dbAPi.updateUserPrefs(userPrefs: oldUserPrefs);
    return returnUpdatedPrefs ? await getUserPrefs() : null;
  }

  // search favoritesList for ID
  Future<bool> getIdFromFavoritesList({int itemId}) async {
    final userPrefs = await _dbAPi.fetchUserPrefs();
    return userPrefs.favorites.indexOf(itemId) == -1;
  }
// update the favorites list

  Future<UserPrefs> updateItemInFavorites(
      {int itemId, bool returnUpdatedPrefs = true}) async {
    UserPrefs oldUserPrefs = await _dbAPi.fetchUserPrefs();
    if (await getIdFromFavoritesList(itemId: itemId)) {
      oldUserPrefs.favorites.remove(itemId);
    } else {
      oldUserPrefs.favorites.add(itemId);
    }
    await _dbAPi.updateUserPrefs(userPrefs: oldUserPrefs);
    return returnUpdatedPrefs ? await _dbAPi.fetchUserPrefs() : null;
  }

  Future<int> updateFavorites({UserPrefs userPrefs}) async {
    return await _dbAPi.updateUserPrefs(userPrefs: userPrefs);
  }

// clear comments table
// clear all items

}

_Repository _repository = _Repository();
_Repository get getRepository => _repository;
