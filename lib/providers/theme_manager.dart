import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter_register_login_firebase/providers/settings_provider.dart';

final appThemeProvider = StateNotifierProvider((ref) => AppThemeNotifier());