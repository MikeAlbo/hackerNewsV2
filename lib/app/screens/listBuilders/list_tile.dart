import 'package:flutter/material.dart';
import 'package:hacker_news/APIs/api_helpers.dart';
import 'package:hacker_news/helpers/date_time.dart';
import 'package:jiffy/jiffy.dart';

import '../../../Models/item.dart';

//todo: replace fake icon colors and icon with actual data driven params

Widget buildListTile(
    {BuildContext context, ItemModel item, IdListName idListName}) {
  return ListTile(
    contentPadding: EdgeInsets.all(15.0),
    //isThreeLine: item.url != "" ? true : false,
    title: Text(
      item.title,
      overflow: TextOverflow.ellipsis,
    ),
    subtitle: subtitleBuilder(itemModel: item, idListName: idListName),
    trailing: IconButton(
      color: item.id % 2 == 0 ? Colors.grey[400] : Colors.redAccent,
      icon:
          item.id % 2 == 0 ? Icon(Icons.bookmark_border) : Icon(Icons.bookmark),
      onPressed: () {},
    ),
  );
}

Widget subtitleBuilder({ItemModel itemModel, IdListName idListName}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            _chooseArticleIcon(idListName: idListName),
            size: 12.0,
            color: Colors.grey[600],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              "${_formatDateByString(itemModel: itemModel)}",
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 2.0),
        child: Text(
          "${_trimUrl(itemModel.url)} ",
          overflow: TextOverflow.fade,
        ),
      ),
    ],
  );
}

IconData _chooseArticleIcon({IdListName idListName}) {
  IconData icon;
  switch (idListName) {
    case IdListName.jobStories:
      icon = Icons.work;
      break;
    case IdListName.topStories:
      icon = Icons.library_books;
      break;
    case IdListName.askStories:
      icon = Icons.question_answer;
      break;
    case IdListName.showStories:
      icon = Icons.web;
      break;
    case IdListName.newStories:
      icon = Icons.fiber_new;
      break;
    default:
      icon = Icons.library_books;
  }
  return icon;
}

String _formatDateByString({ItemModel itemModel}) {
  String formattedTime = _formatDate(time: itemModel.time);
  if (formattedTime.contains("ago")) {
    return "$formattedTime |  by: ${itemModel.by}";
  }
  return "$formattedTime | by: ${itemModel.by}";
}

String _formatDate({int time}) {
  int itemTime = secondsToMilliseconds(seconds: time);
  int currentTime = DateTime.now().millisecondsSinceEpoch;
  DateTime fromMillSec = DateTime.fromMillisecondsSinceEpoch(itemTime);
  if ((currentTime - itemTime) < Duration(hours: 24).inMilliseconds) {
    return Jiffy(fromMillSec.toString(), "yyyy-MM-dd").fromNow();
  } else if ((currentTime - itemTime) < Duration(days: 7).inMilliseconds) {
    return Jiffy(fromMillSec).format("EEEE");
  }
  return Jiffy(fromMillSec).format("yMMMMd");
}

String _trimUrl(String url) {
  String host = Uri.parse(url).host;
  host = host.contains("www.") ? host.substring(4) : host;
  host = host.length > 40 ? "${host.substring(0, 37)}..." : host;
  return host;
}
