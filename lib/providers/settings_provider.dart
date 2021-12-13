import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppThemeNotifier extends StateNotifier<bool> {
  AppThemeNotifier(): super(false);

  void setLightTheme() => state = false;
  void setDarkTheme() => state = true;
}
