  
  import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsNotifier extends StateNotifier<SettingsState> {


  SettingsNotifier(this.read) : super(SettingsState.initial()) {
    loadData();
  }

  
  void setTheme(String theme) async {
    
  }
}