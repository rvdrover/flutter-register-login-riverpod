import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Theme {
  final ThemeMode themeMode;
  final bool isToggle;

  Theme({this.isToggle = false, this.themeMode = ThemeMode.system});
}

class SettingsNotifier extends StateNotifier<Theme> {
  SettingsNotifier() : super(Theme()) {
    toggle();
  }
  SharedPreferences? prefs;

  Future<bool> toggle() async {
    prefs = await SharedPreferences.getInstance();
    Brightness brightness =
        SchedulerBinding.instance!.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    bool isLightMode = brightness == Brightness.light;
    int _theme = prefs?.getInt("theme") ?? state.themeMode.index;
    bool _toggle = prefs?.getBool("toggle") ?? state.isToggle;

    if (_theme == 0 && isLightMode) {
      _toggle = false;
    } else if (_theme == 0 && isDarkMode) {
      _toggle = true;
    }
    state = Theme(isToggle: _toggle, themeMode: ThemeMode.values[_theme]);
    return _toggle;
  }

  Future<void> setLightTheme() async {
    state = Theme(isToggle: false, themeMode: ThemeMode.light);
    await prefs?.setInt("theme", state.themeMode.index);
    await prefs?.setBool("toggle", state.isToggle);
  }

  Future<void> setDarkTheme() async {
    state = Theme(isToggle: true, themeMode: ThemeMode.dark);
    await prefs?.setInt("theme", state.themeMode.index);
    await prefs?.setBool("toggle", state.isToggle);
  }
}
