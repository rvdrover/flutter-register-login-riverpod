import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_flutter_register_login_firebase/providers/top_level_providers.dart';
import 'package:riverpod_flutter_register_login_firebase/constants/keys.dart';
import 'package:riverpod_flutter_register_login_firebase/constants/strings.dart';
import 'package:riverpod_flutter_register_login_firebase/widgets/alerts/alert_dialogs.dart';
import 'package:riverpod_flutter_register_login_firebase/widgets/alerts/exception_alert_dialog.dart';
import 'package:riverpod_flutter_register_login_firebase/widgets/avatar/avatar.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({Key? key}) : super(key: key);

  Future<void> _signOut(BuildContext context, FirebaseAuth firebaseAuth) async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      unawaited(showExceptionAlertDialog(
        context: context,
        title: Strings.logoutFailed,
        exception: e,
      ));
    }
  }

  Future<void> _confirmSignOut(
      BuildContext context, FirebaseAuth firebaseAuth) async {
    final bool didRequestSignOut = await showAlertDialog(
          context: context,
          title: Strings.logout,
          content: Strings.logoutAreYouSure,
          cancelActionText: Strings.cancel,
          defaultActionText: Strings.logout,
        ) ??
        false;
    if (didRequestSignOut == true) {
      await _signOut(context, firebaseAuth);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    final user = firebaseAuth.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.accountPage),
        actions: <Widget>[
          TextButton(
            key: const Key(Keys.logout),
            child: const Text(
              Strings.logout,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: () => _confirmSignOut(context, firebaseAuth),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(130.0),
          child: _buildUserInfo(user),
        ),
      ),
    );
  }

  Widget _buildUserInfo(User user) {
    print(user.photoURL);
    return Column(
      children: [
        Avatar(
          photoUrl: user.photoURL,
          radius: 50,
          borderColor: Colors.black54,
          borderWidth: 2.0,
        ),
        const SizedBox(height: 8),
        if (user.displayName != null)
          Text(
            user.displayName!,
            style: const TextStyle(color: Colors.white),
          ),
        const SizedBox(height: 8),
      ],
    );
  }
}
