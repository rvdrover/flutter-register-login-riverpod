import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter_register_login_firebase/pages/sign_in_page/sign_in_manager.dart';
import 'package:riverpod_flutter_register_login_firebase/services/firebase_auth_services.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authStateChangesProvider = StreamProvider<User?>(
    (ref) => ref.watch(firebaseAuthProvider).authStateChanges());

final firebaseAuthServicesProvider =
    Provider<FirebaseAuthServices>((ref) => FirebaseAuthServices());

final signInManagerProvider =
    StateNotifierProvider<SignInManager, SignIn>((ref) {
  return SignInManager();
});
