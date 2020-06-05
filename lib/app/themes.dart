import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData baseTheme = ThemeData.dark();

/// App Colors
Color _primaryColor = Colors.grey[800];
Color _accentColor = Colors.grey[100];
Color _bodyTextColor = Colors.black;
Color _subtitleTextColor = Colors.grey[600];
Color _titleTextColor = Colors.blueGrey;
Color _headingTextColor = Colors.grey[900];
Color _htmlLinkColor = Colors.blue[700];
Color _favoritesActiveColor = Colors.red[600];
Color _favoritesInactiveColor = Colors.grey[400];
Color _buttonBarText = Colors.grey[900];
Color _activeButtonColor = Colors.blueGrey[300];
Color _inactiveButtonColor = Colors.blueGrey[600];

/// App Fonts

ThemeData hNTheme = baseTheme.copyWith(
    appBarTheme: _appBarTheme, textTheme: GoogleFonts.rokkittTextTheme());

AppBarTheme _appBarTheme = AppBarTheme(
  color: _accentColor,
);
