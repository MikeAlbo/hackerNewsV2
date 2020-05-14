import 'dart:async';

import 'package:hacker_news/APIs/api_helpers.dart';
import 'package:hacker_news/APIs/repository.dart';
import 'package:hacker_news/Models/ids_list.dart';
import 'package:rxdart/rxdart.dart';

class StoriesBloc {
  final repo = getRepository;
  final PublishSubject<Map<String, IdsListModel>> _allListOfIds =
      PublishSubject<Map<String, IdsListModel>>();
  final PublishSubject<IdsListModel> _singleListOfIds =
      PublishSubject<IdsListModel>();
  IdListName _idListName = IdListName.newStories;

  Stream<Map<String, IdsListModel>> get listOfIds => _allListOfIds.stream;
  Stream<IdsListModel> get singleListOfIds => _singleListOfIds.stream;

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

  StoriesBloc();

  dispose() {
    _allListOfIds.close();
    _singleListOfIds.close();
  }
}
