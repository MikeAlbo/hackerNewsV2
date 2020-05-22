import 'dart:async';

import 'package:hacker_news/APIs/api_helpers.dart';
import 'package:hacker_news/APIs/repository.dart';
import 'package:hacker_news/Models/ids_list.dart';
import 'package:hacker_news/Models/user_prefs.dart';
import 'package:rxdart/rxdart.dart';

//todo: have removed references to singleListOfIds -> stream should be removed

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
    print("--> list name in bloc ${idListName.toString()}");
    final list = await repo.getListOfIds(idListName);
    _singleListOfIds.sink.add(list);
  }

  setCurrentListName({IdListName idListName}) => _idListName = idListName;
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

  // update lastUpdated -- method called when story list are refreshed
  updateLastUpdated() async {
    UserPrefs userPrefs = await repo.updateLastUpdatedField();
    _userPrefs.sink.add(userPrefs);
  }

  dispose() {
    _allListOfIds.close();
    _singleListOfIds.close();
    _userPrefs.close();
  }
}
