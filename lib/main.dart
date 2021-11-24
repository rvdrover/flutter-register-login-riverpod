//import 'package:auth_widget_builder/auth_widget_builder.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter_register_login_firebase/routing/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/auth_widget.dart';
import 'app/home/account/account_page.dart';
import 'app/onboarding/onboarding_page.dart';
import 'app/onboarding/onboarding_view_model.dart';
import 'app/sign_in/sign_in_page.dart';
import 'app/top_level_providers.dart';
import 'services/shared_preferences_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    overrides: [
      sharedPreferencesServiceProvider.overrideWithValue(
        SharedPreferencesService(sharedPreferences),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.indigo),
      debugShowCheckedModeBanner: false,
      home: AuthWidget(
        nonSignedInBuilder: (_) => Consumer(
          builder: (context, ref, _) {
            final didCompleteOnboarding =
                ref.watch(onboardingViewModelProvider);
            return didCompleteOnboarding ? const SignInPage() : const OnboardingPage();
          },
        ),
        signedInBuilder: (_) => const AccountPage(),
      ),
      onGenerateRoute: (settings) =>
          AppRouter.onGenerateRoute(settings, firebaseAuth),
    );
  }
}
