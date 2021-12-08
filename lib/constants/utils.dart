import 'package:flutter/material.dart';

ThemeMode getThemeMode(String type) {
  ThemeMode themeMode = ThemeMode.system;
  switch (type) {
    case "System":
      themeMode = ThemeMode.system;
      break;
    case "Dark":
      themeMode = ThemeMode.dark;
      break;
    case "Light":
      themeMode = ThemeMode.light;
      break;
  }
  return themeMode;
}

final themeModes = ["System", "Dark", "Light"];