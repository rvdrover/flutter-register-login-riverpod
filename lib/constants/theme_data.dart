import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    appBarTheme: const AppBarTheme(
      color: Colors.blueGrey,
    ),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    unselectedWidgetColor: Colors.black45,
    focusColor: Colors.black,
  );

  static final ThemeData dark = ThemeData(
    primaryColor: Colors.black12,
    appBarTheme: const AppBarTheme(
      color: Colors.black,
    ),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    focusColor: Colors.white,
  );
}
