import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_flutter_register_login_firebase/services/firebase_auth_services.dart';


class SignIn {
  bool isLoading;
  dynamic error;

  SignIn({
    this.isLoading = false,
    this.error,
  });
}

class SignInNotifier extends StateNotifier<SignIn> {
  SignInNotifier() : super(SignIn());

  final FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();

  Future<void> _signIn(Future<UserCredential?> signInMethod) async {
    try {
      state = SignIn(error: null);
      state = SignIn(isLoading: true);
      await signInMethod;
    } catch (e) {
      state = SignIn(error: e);
      rethrow;
    } finally {
      state = SignIn(isLoading: false);
    }
  }

  Future<void> signInWithGoogle() async {
    return await _signIn(firebaseAuthServices.signInWithGoogleManager());
  }

  Future<void> signInWithFacebook() async {
    return await _signIn(firebaseAuthServices.signInWithFacebookManager());
  }

  Future<void> signInWithTwitter() async {
    return await _signIn(firebaseAuthServices.signInWithTwitterManager());
  }

  Future<void> signInWithGithub(BuildContext context) async {
    return await _signIn(firebaseAuthServices.signInWithGitHubManager(context));
  }

  Future<void> signInAnonymously() async {
    return await _signIn(firebaseAuthServices.signInAnonymouslyManager());
  }
}
