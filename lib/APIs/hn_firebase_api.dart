/*
* hn firebase api
* HnFireBaseApi handles all the app access to and from the Hacker News Firebase API
* API reference located at https://github.com/HackerNews/API
* */

import 'dart:async';
import 'dart:convert';

import 'package:hacker_news/APIs/api_helpers.dart';
import 'package:hacker_news/Models/item.dart';
import 'package:http/http.dart' show Client, Response;

import '../Models/ids_list.dart';
import '../helpers/date_time.dart';

class HNFireBaseApi {
  final _rootUrl = 'https://hacker-news.firebaseio.com/v0';

  Client _client = Client();

  // fetch a list of IDs from the HN Firebase API
  Future<IdsListModel> fetchListOfIds(IdListName listName) async {
    final String _endPointName = getApiEndPoint(listName);
    final String _listName = getListName(listName);
    final String _url = "$_rootUrl/$_endPointName.json";
    final Response _response = await _client.get(_url);
    final List<int> _ids = json.decode(_response.body).cast<int>();
    final int _currentTime = timeNowInMilliseconds();
    final Map<String, dynamic> _jsonItem = {
      "listName": _listName,
      "lastUpdated": _currentTime,
      "storyIdsList": _ids
    };
    return IdsListModel.fromJSON(_jsonItem);
  }

  // fetch an Item (Item / Comment) from the HN Firebase API
  Future<ItemModel> fetchItem(int id) async {
    final String _url = "$_rootUrl/item/$id.json";
    final Response response = await _client.get(_url);
    Map<String, dynamic> parsedJson = json.decode(response.body);
    if (parsedJson == null) {
      //return ItemModel.fromJSON(parsedJson);
      return null;
    }
    parsedJson["lastUpdated"] = timeNowInMilliseconds();
    return ItemModel.fromJSON(parsedJson);
  }
}
