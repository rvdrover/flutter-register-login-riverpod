import 'package:flutter/material.dart';
import 'package:riverpod_flutter_register_login_firebase/providers/setting_provider/settings_notifier.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({
    Key? key,
    required this.themeMode,
    required this.themeModeNotifier,
  }) : super(key: key);

  final bool themeMode;
  final SettingsNotifier themeModeNotifier;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Switch(
            value: themeMode,
            onChanged: (val) {
              if (val) {
                themeModeNotifier.setDarkTheme();
              } else {
                themeModeNotifier.setLightTheme();
              }
            },
          )
        ],
      ),
    );
  }
}
