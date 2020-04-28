/*
* hn firebase api
* HnFireBaseApi handles all the app access to and from the Hacker News Firebase API
* API reference located at https://github.com/HackerNews/API
* */

import 'dart:async';
import 'dart:convert';

import 'package:hacker_news/APIs/api_helpers.dart';
import 'package:http/http.dart' show Client, Response;

import '../Models/ids_list.dart';
import '../helpers/date_time.dart';

class HNFireBaseApi {
  final _rootUrl = 'https://hacker-news.firebaseio.com/v0';

  Client _client = Client();

  Future<IdsListModel> fetchListOfIds(IdListType listType) async {
    final String _listName = getApiEndPoint(listType);
    final String _url = "$_rootUrl/$_listName.json";
    final Response _response = await _client.get(_url);
    final List<int> _ids = json.decode(_response.body);
    final int _currentTime = timeNowInMilliseconds();
    final Map<String, dynamic> _jsonItem = {
      "listName": _listName,
      "lastUpdated": _currentTime,
      "storyIdsList": _ids
    };
    return IdsListModel.fromJSON(_jsonItem);
  }
}
