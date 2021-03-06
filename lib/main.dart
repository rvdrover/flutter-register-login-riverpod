//import 'package:auth_widget_builder/auth_widget_builder.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter_register_login_firebase/pages/auth_widget.dart';
import 'package:riverpod_flutter_register_login_firebase/pages/sign_in_page/sign_in_page.dart';
import 'package:riverpod_flutter_register_login_firebase/providers/setting_provider/settings_provider.dart';
import 'package:riverpod_flutter_register_login_firebase/providers/sign_in_provider/sign_in_provider.dart';
import 'package:riverpod_flutter_register_login_firebase/routing/app_router.dart';

import 'constants/theme_data.dart';
import 'pages/account_page/account_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    final themeMode = ref.watch(settingsProvider);
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode.themeMode ,
      debugShowCheckedModeBanner: false,
      home: AuthWidget(
        nonSignedInBuilder: (_) => const SignInPage(),
        signedInBuilder: (_) => const AccountPage(),
      ),
      onGenerateRoute: (settings) =>
          AppRouter.onGenerateRoute(settings, firebaseAuth),
    );
  }
}
