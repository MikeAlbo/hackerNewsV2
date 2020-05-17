import 'dart:async';

import 'package:hacker_news/APIs/api_helpers.dart';
import 'package:hacker_news/APIs/repository.dart';
import 'package:hacker_news/Models/ids_list.dart';
import 'package:hacker_news/Models/user_prefs.dart';
import 'package:rxdart/rxdart.dart';

class StoriesBloc {
  final repo = getRepository;
  final PublishSubject<Map<String, IdsListModel>> _allListOfIds =
      PublishSubject<Map<String, IdsListModel>>();
  final PublishSubject<IdsListModel> _singleListOfIds =
      PublishSubject<IdsListModel>();
  IdListName _idListName = IdListName.newStories;

  final PublishSubject<UserPrefs> _userPrefs = PublishSubject<UserPrefs>();

  Stream<Map<String, IdsListModel>> get listOfIds => _allListOfIds.stream;
  Stream<IdsListModel> get singleListOfIds => _singleListOfIds.stream;
  Stream<UserPrefs> get userPrefs => _userPrefs.stream;

  fetchAllList() async {
    final list = await repo.getAllListOfIds();
    _allListOfIds.sink.add(list);
  }

  fetchSingleList({IdListName idListName: IdListName.askStories}) async {
    final list = await repo.getListOfIds(idListName);
    _singleListOfIds.sink.add(list);
  }

  addCurrentListName({IdListName idListName}) => _idListName = idListName;
  IdListName get getIdListName => _idListName;

  // user prefs
  // init the user prefs
  Future<int> initUserPrefs() {
    return repo.initUserPrefs();
  }

  getUserPrefs() async {
    UserPrefs userPrefs = await repo.getUserPrefs();
    _userPrefs.sink.add(userPrefs);
  }

  // update bool settings
  updateSettingsBool({IdListName idListName}) async {
    UserPrefs userPrefs = await repo.updateShowListBool(idListName: idListName);
    _userPrefs.sink.add(userPrefs);
  }

  // update favoritesList
//  updateFavoritesList({int itemId}) async {
//    UserPrefs userPrefs = await repo.updateItemInFavorites(itemId: itemId);
//    _userPrefs.sink.add(userPrefs);
//  }

  // update lastUpdated -- method called when story list are refreshed
  updateLastUpdated() async {
    UserPrefs userPrefs = await repo.updateLastUpdatedField();
    _userPrefs.sink.add(userPrefs);
  }

  List<int> favoritesList = [];

  void preloadFavoritesList() async {
    UserPrefs userPrefs = await repo.getUserPrefs();
    favoritesList = userPrefs.favorites.cast<int>();
  }

  bool isItemAFavorite({int itemId}) {
    return favoritesList.indexOf(itemId) != -1;
  }

  void updateFavoritesList({int itemId}) async {
    if (isItemAFavorite(itemId: itemId)) {
      favoritesList.remove(itemId);
    } else {
      favoritesList.add(itemId);
    }
    UserPrefs userPrefs = await repo.getUserPrefs();
    userPrefs.favorites = favoritesList;
    await repo.updateFavorites(userPrefs: userPrefs);
  }

  StoriesBloc() {
    //preloadFavoritesList();
  }

  dispose() {
    _allListOfIds.close();
    _singleListOfIds.close();
    _userPrefs.close();
  }
}
