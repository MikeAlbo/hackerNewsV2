import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//todo: incorporate theme data

enum TitleTextTheme { AppHeading, SectionHeading, StoryView }

buildAppBar(
    {@required String title,
    @required bool centerTitle,
    @required TitleTextTheme titleTextTheme,
    PreferredSizeWidget bottom,
    List<Widget> actions}) {
  return AppBar(
    elevation: 1.0,
    title: Text(
      title,
      style: _getTextStyle(titleTextTheme),
    ),
    centerTitle: centerTitle ? true : false,
    backgroundColor: Colors.white,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black87),
    bottom: bottom,
    actions: actions,
  );
}

TextStyle _sectionTitle() {
  // if this is updated, must update the SliverAppBar for the story view
  return GoogleFonts.robotoSlab(
      color: Colors.grey[900], fontSize: 24.0, letterSpacing: 1.25);
}

TextStyle _storyTitle() {
  return GoogleFonts.robotoSlab(
      color: Colors.grey[900], fontSize: 16.0, letterSpacing: 1.1);
}

TextStyle _appHeadingTitle() {
  return GoogleFonts.robotoSlab(
      color: Colors.grey[900], fontSize: 32.0, letterSpacing: 1.5);
}

TextStyle _getTextStyle(TitleTextTheme titleTextTheme) {
  switch (titleTextTheme) {
    case TitleTextTheme.AppHeading:
      return _appHeadingTitle();
      break;
    case TitleTextTheme.SectionHeading:
      return _sectionTitle();
      break;
    case TitleTextTheme.StoryView:
      return _storyTitle();
      break;
    default:
      return _sectionTitle();
  }
}
