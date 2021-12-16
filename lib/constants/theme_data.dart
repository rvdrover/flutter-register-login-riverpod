import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    appBarTheme: const AppBarTheme(
      color: Colors.blueGrey,
    ),
    brightness: Brightness.light,
    unselectedWidgetColor: Colors.black45,
    focusColor: Colors.black,
    primarySwatch: Colors.orange,
    primaryColor: Colors.orange[500],
    primaryColorBrightness: Brightness.light,
    scaffoldBackgroundColor: Colors.grey[200],
  );

  static final ThemeData dark = ThemeData(
    appBarTheme: const AppBarTheme(
      color: Colors.black,
    ),
    brightness: Brightness.dark,
    focusColor: Colors.white,
  primaryColor: Colors.red,
  primaryColorBrightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.grey[850],
  );
}
