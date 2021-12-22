import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    appBarTheme: const AppBarTheme(
      color: Colors.blueGrey,
    ),
    brightness: Brightness.light,
    unselectedWidgetColor: Colors.black45,
    focusColor: Colors.black,
    primaryColorBrightness: Brightness.light,
    scaffoldBackgroundColor: Colors.grey[200],
  );

  static final ThemeData dark = ThemeData(
    appBarTheme: const AppBarTheme(
      color: Colors.black,
    ),
    brightness: Brightness.dark,
    focusColor: Colors.white,
  primaryColorBrightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.grey[850],
  );
}
