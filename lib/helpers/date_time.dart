/*
* Date and Time Helpers
* helpers  to handle fromEpoch conversions along with date/ time formatting for display
* */

import 'package:meta/meta.dart';

// convert UNIX Seconds from Epoch time to milliseconds
// the HN API stores timestamps in the UNIX seconds format
int secondsToMilliseconds({int seconds}) {
  return seconds * 1000;
}

// returns the current time stamp in milliseconds
int timeNowInMilliseconds() {
  return DateTime.now().millisecondsSinceEpoch;
}

/// Returns a bool if timeStamp is older than provided duration
///
/// the bastTime parameter is optional and defaults to DateTime.now()
bool isExpired(
    {@required Duration duration, @required int timeStamp, DateTime baseTime}) {
  final int timeDifference =
      (baseTime ?? DateTime.now()).millisecondsSinceEpoch - timeStamp;
  return Duration(milliseconds: timeDifference) > duration;
} //todo: write test for isExpired

//String formattedTimeDifference({@required int timeStamp}){}
// formatted time difference between two times
// i.e. the time an article was published and the current time.
