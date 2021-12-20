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
          const Text('White'),
          Switch(
            inactiveTrackColor:Colors.black12 ,
            inactiveThumbColor: Colors.white10,
            activeColor:  Colors.black87,
            activeTrackColor:  Colors.black45,
            value: themeMode,
            onChanged: (val) {
              if (val) {
                themeModeNotifier.setDarkTheme();
              } else {
                themeModeNotifier.setLightTheme();
              }
            },
          ),const Text('Dark'),
        ],
      ),
    );
  }
}
