import 'dart:async';

import 'package:hacker_news/APIs/repository.dart';
import 'package:hacker_news/Models/ids_list.dart';
import 'package:rxdart/rxdart.dart';

class StoriesBloc {
  final repo = getRepository;
  final PublishSubject<Map<String, IdsListModel>> _allListOfIds =
      PublishSubject<Map<String, IdsListModel>>();

  Stream<Map<String, IdsListModel>> get listOfIds => _allListOfIds.stream;

  fetchAllList() async {
    final list = await repo.getAllListOfIds();
    _allListOfIds.sink.add(list);
  }

  StoriesBloc();

  dispose() {
    _allListOfIds.close();
  }
}
