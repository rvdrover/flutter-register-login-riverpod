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
}
