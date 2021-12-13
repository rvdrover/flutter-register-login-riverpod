import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Theme {
  final ThemeMode themeMode;
  final bool isToggle;

  Theme({this.isToggle = false, this.themeMode = ThemeMode.system});
}

class SettingsNotifier extends StateNotifier<Theme> {
  SettingsNotifier() : super(Theme()){
setLightTheme();
  }

  void setLightTheme() => state = Theme(isToggle: false,themeMode: ThemeMode.light);
  void setDarkTheme() => state = Theme(isToggle: true,themeMode: ThemeMode.dark);
}
