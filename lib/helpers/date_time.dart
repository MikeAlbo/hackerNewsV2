/*
* Date and Time Helpers
* helpers  to handle fromEpoch conversions along with date/ time formatting for display
* */

// convert UNIX Seconds from Epoch time to milliseconds
// the HN API stores timestamps in the UNIX seconds format
int secondsToMilliseconds({int seconds}) {
  return seconds * 1000;
}

// returns the current time stamp in milliseconds
int timeNowInMilliseconds() {
  return DateTime.now().millisecondsSinceEpoch;
}
