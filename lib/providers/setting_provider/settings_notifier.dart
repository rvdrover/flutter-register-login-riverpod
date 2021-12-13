import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsNotifier extends StateNotifier<bool> {
  SettingsNotifier(): super(false);

  void setLightTheme() => state = false;
  void setDarkTheme() => state = true;
}
