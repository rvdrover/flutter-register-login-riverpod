import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter_register_login_firebase/providers/setting_provider/settings_notifier.dart';

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, Theme>((ref) => SettingsNotifier());
