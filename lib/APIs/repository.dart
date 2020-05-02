/*
* repository
* the repo handles the incoming request from the app
* the repo handles ALL api calls to the DB and HN Firebase API
* the repo then returns all data, properly formatted back to the app
* */

import 'dart:async';

import 'package:hacker_news/APIs/api_helpers.dart';
import 'package:hacker_news/Models/ids_list.dart';

class Repository {
  // retrieve all list from HN
  Future<IdsListModel> getListofIds(IdListName listType) async {
    // check to see if list is in db
    // if list is in db, check expiration
    // if not expired return list
    // if not in db or expired, can HN API
    // write to db
    // return list
  }
  // retrieve single list from HN
  // validate expiration of list data (use helper function)
  // clear list table (possibly use db helper)
  // write list to DB
  // retrieve all list from DB
  // retrieve single list from DB
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
