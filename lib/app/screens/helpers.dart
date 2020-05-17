import 'package:flutter/material.dart'
    show required, Divider, Colors, Icons, IconData;
import 'package:hacker_news/APIs/api_helpers.dart';
import 'package:hacker_news/Models/item.dart';
import 'package:hacker_news/helpers/date_time.dart';
import 'package:jiffy/jiffy.dart';

/// trim a string and optionally add a padding char
///
/// returns the original string if less than the maxLength
/// if padRight  is indicated, it will apply padding to the right
/// if padLeft  is indicated, it will apply padding to the left
/// if no padding indicated, it will return a  substring of the original text
enum PadDirection { padLeft, padRight }
String trimBodyText(
    {@required String originalText,
    int maxLength = 100,
    PadDirection padDirection,
    padChar = "",
    int padLength = 3}) {
  if (originalText.length < maxLength) {
    return originalText;
  }

  if (padDirection == null) {
    return originalText.substring(0, maxLength);
  } else if (padDirection == PadDirection.padRight) {
    return originalText.substring(0, maxLength).padRight(padLength, padChar);
  } else {
    return originalText.substring(0, maxLength).padLeft(padLength, padChar);
  }
}

/// insert a Divider Widget
///
/// Insert a material widget divider with preset values for title and non
/// todo: could be updated to take  thickness param
Divider insertDivider({@required bool isTitle}) {
  return Divider(
    thickness: isTitle ? 1.0 : 0.5,
    height: 1.0,
    color: isTitle ? Colors.black87 : Colors.grey[300],
  );
}

/// format a string that contains a date/time and a by field
///
///
/// !!-- requires the ItemModel class ---!!
/// this method is not reusable outside of the current project
String formatDateByString({ItemModel itemModel}) {
  String formattedTime = formatDate(time: itemModel.time);
  if (formattedTime.contains("ago")) {
    return "$formattedTime |  by: ${itemModel.by}";
  }
  return "$formattedTime | by: ${itemModel.by}";
}

///  returns a formatted date, REQUIRES THE JIFFY PKG TO BE INSTALLED
///
///
String formatDate({int time, bool convertFromSeconds = true}) {
  int itemTime =
      convertFromSeconds ? secondsToMilliseconds(seconds: time) : time;
  int currentTime = DateTime.now().millisecondsSinceEpoch;
  DateTime fromMillSec = DateTime.fromMillisecondsSinceEpoch(itemTime);
  if ((currentTime - itemTime) < Duration(hours: 24).inMilliseconds) {
    return Jiffy(fromMillSec.toString(), "yyyy-MM-dd").fromNow();
  } else if ((currentTime - itemTime) < Duration(days: 7).inMilliseconds) {
    return Jiffy(fromMillSec).format("EEEE");
  }
  return Jiffy(fromMillSec).format("yMMMMd");
}

/// Trims a URL to a preset length to fit within a list tile
///
///
String trimUrl(String url) {
  String host = Uri.parse(url).host;
  host = host.contains("www.") ? host.substring(4) : host;
  host = host.length > 40 ? "${host.substring(0, 37)}..." : host;
  return host;
}

/// choose the article icon dependant upon the list type
///
///
IconData chooseArticleIcon({IdListName idListName}) {
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
