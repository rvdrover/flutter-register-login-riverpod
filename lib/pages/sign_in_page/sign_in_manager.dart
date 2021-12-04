import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_flutter_register_login_firebase/services/firebase_auth_services.dart';

// class SignInManager extends ChangeNotifier {
//   bool isLoading = false;
//   dynamic error;
//   FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();

//   Future<void> _signIn(Future<UserCredential?> Function() signInMethod) async {
//     try {
//       error = null;
//       isLoading = true;
//       notifyListeners();
//       await signInMethod();
//     } catch (e) {
//       error = e;
//       rethrow;
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }

//   Future<void> signInWithGoogle() async {
//     return await _signIn(firebaseAuthServices.signInWithGoogleManager);
//   }

//   Future<void> signInWithFacebook() async {
//     return await _signIn(firebaseAuthServices.signInWithFacebookManager);
//   }

//   Future<void> signInAnonymously() async {
//     return await _signIn(firebaseAuthServices.signInAnonymouslyManager);
//   }
// }

class SignIn {
  bool isLoading;
  dynamic error;

  SignIn({
    this.isLoading = false,
    this.error,
  });
}

class SignInManager extends StateNotifier<SignIn> {
  SignInManager() : super(SignIn());

  final FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();

  Future<void> _signIn(Future<UserCredential?> Function() signInMethod) async {
    try {
      state = SignIn(error: null);
      state = SignIn(isLoading: true);
      await signInMethod();
    } catch (e) {
      state = SignIn(error: e);
      rethrow;
    } finally {
      state = SignIn(isLoading: false);
    }
  }

  Future<void> signInWithGoogle() async {
    return await _signIn(firebaseAuthServices.signInWithGoogleManager);
  }

  Future<void> signInWithFacebook() async {
    return await _signIn(firebaseAuthServices.signInWithFacebookManager);
  }

  Future<void> signInAnonymously() async {
    return await _signIn(firebaseAuthServices.signInAnonymouslyManager);
  }
}
