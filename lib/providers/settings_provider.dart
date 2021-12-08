  
//   import 'package:flutter_riverpod/flutter_riverpod.dart';

// class SettingsNotifier extends StateNotifier<SettingsState> {


//   SettingsNotifier(this.read) : super(SettingsState.initial()) {
//     loadData();
//   }

  
//   void setTheme(String theme) async {
//     state = SettingsState.loading();
//     await read(flutterDatabase).write(key: "theme", value: theme);
//     details = details.copyWith(themeMode: theme);
//     state = SettingsState.data(details: details);
//   }
// }