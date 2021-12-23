import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:riverpod_flutter_register_login_firebase/constants/api_keys_decoder.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:riverpod_flutter_register_login_firebase/constants/commen_strings.dart';
import 'package:riverpod_flutter_register_login_firebase/widgets/alerts/exception_alert_dialog.dart';

class FirebaseAuthServices {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential?> signInWithFacebookManager() async {
    final LoginResult authResult = await FacebookAuth.instance.login();
    if (authResult.status == LoginStatus.success) {
      final OAuthCredential credential =
          FacebookAuthProvider.credential(authResult.accessToken!.token);
      return await auth.signInWithCredential(credential);
    } else if (authResult.status == LoginStatus.cancelled) {
      // throw PlatformException(code: 'ERROR_ABORTED_BY_USER', message: result.message);
      return null;
    } else if (authResult.status == LoginStatus.failed) {
      throw PlatformException(code: '', message: authResult.message);
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

  Future<UserCredential?> signInWithTwitterManager() async {
    final apiKeys = await ApiKeysDecoder().decoder();

    final twitterLogin = TwitterLogin(
      apiKey: apiKeys['TWITTER_API_KEY'],
      apiSecretKey: apiKeys['TWITTER_API_SECRET_KEY'],
      redirectURI: apiKeys['TWITTER_API_REDIRECT_URL'],
    );

    final authResult = await twitterLogin.login();
    if (authResult.status == TwitterLoginStatus.loggedIn) {
      final AuthCredential twitterAuthCredential =
          TwitterAuthProvider.credential(
        accessToken: authResult.authToken!,
        secret: authResult.authTokenSecret!,
      );

      return await auth.signInWithCredential(twitterAuthCredential);
    } else if (authResult.status == TwitterLoginStatus.cancelledByUser) {
      // throw PlatformException(code: 'ERROR_ABORTED_BY_USER', message: result.message);
      return null;
    } else if (authResult.status == TwitterLoginStatus.error) {
      throw PlatformException(code: '', message: authResult.errorMessage);
    }
  }

  Future<UserCredential?> signInWithGitHubManager(BuildContext context) async {
    final apiKeys = await ApiKeysDecoder().decoder();

    final GitHubSignIn gitHubSignIn = GitHubSignIn(
      clientId: apiKeys['GITHUB_CLIENT_ID'],
      clientSecret: apiKeys['GITHUB_CLIENT_SECRET'],
      redirectUrl: apiKeys['FIREBASE_REDIRECT_URL'],
      title: 'GitHub Connection',
      centerTitle: true,
    );

    final authResult = await gitHubSignIn.signIn(context);
    if (authResult.status == GitHubSignInResultStatus.ok) {
      final githubAuthCredential =
          GithubAuthProvider.credential(authResult.token!);
      return await auth.signInWithCredential(githubAuthCredential);
    } else if (authResult.status == GitHubSignInResultStatus.cancelled) {
      // throw PlatformException(code: 'ERROR_ABORTED_BY_USER', message: result.message);
    } else if (authResult.status == GitHubSignInResultStatus.failed) {
      throw PlatformException(code: '', message: authResult.errorMessage);
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
