import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInViewModel with ChangeNotifier {
  SignInViewModel({required this.auth});
  final FirebaseAuth auth;
  bool isLoading = false;
  dynamic error;

  Future<void> _signIn(Future<UserCredential> Function() signInMethod) async {
    try {
      isLoading = true;
      notifyListeners();
      await signInMethod();
      error = null;
    } catch (e) {
      error = e;
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signInAnonymously() async {
    await _signIn(auth.signInAnonymously);
  }

  Future<UserCredential?> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final OAuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      return await auth.signInWithCredential(credential);
    }
    return null;
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await auth.signInWithCredential(credential);
  }
}
