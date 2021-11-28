import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_flutter_register_login_firebase/constants/strings.dart';
import 'package:riverpod_flutter_register_login_firebase/widgets/alerts/exception_alert_dialog.dart';

class FirebaseAuthServices{
  final FirebaseAuth auth = FirebaseAuth.instance;
  

  Future<UserCredential?> signInWithFacebookManager() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final OAuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      return await auth.signInWithCredential(credential);
    } else if (result.status == LoginStatus.cancelled) {
      // throw PlatformException(code: 'ERROR_ABORTED_BY_USER', message: result.message);
      return null;
    } else if (result.status == LoginStatus.failed) {
      throw PlatformException(code: '', message: result.message);
    }
  }


  Future<UserCredential?> signInWithGoogleManager() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;
      if (googleAuth!.accessToken != null && googleAuth.idToken != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        return await auth.signInWithCredential(credential);
      } else {
        throw PlatformException(
            code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
            message: 'Missing Google Auth Token');
      }
    } else {
      return null;
      // throw PlatformException(code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  
  Future<UserCredential?> signInAnonymouslyManager() async {
    return await auth.signInAnonymously();
  }



  
  Future<void> signOut(BuildContext context) async {
    try {
      
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      await FacebookAuth.instance.logOut();
      await auth.signOut();
    } catch (e) {
      unawaited(showExceptionAlertDialog(
        context: context,
        title: Strings.logoutFailed,
        exception: e,
      ));
    }
  }
}