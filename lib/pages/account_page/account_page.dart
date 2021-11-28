import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_flutter_register_login_firebase/providers/providers.dart';
import 'package:riverpod_flutter_register_login_firebase/constants/keys.dart';
import 'package:riverpod_flutter_register_login_firebase/constants/strings.dart';
import 'package:riverpod_flutter_register_login_firebase/services/firebase_auth_services.dart';
import 'package:riverpod_flutter_register_login_firebase/widgets/alerts/alert_dialogs.dart';
import 'package:riverpod_flutter_register_login_firebase/widgets/avatar/avatar.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({Key? key}) : super(key: key);

  Future<void> _confirmSignOut(
      BuildContext context, FirebaseAuthServices firebaseAuthServices) async {
    final bool didRequestSignOut = await showAlertDialog(
          context: context,
          title: Strings.logout,
          content: Strings.logoutAreYouSure,
          cancelActionText: Strings.cancel,
          defaultActionText: Strings.logout,
        ) ??
        false;
    if (didRequestSignOut == true) {
      await firebaseAuthServices.signOut(context);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    final user = firebaseAuth.currentUser!;

    final firebaseAuthServices = ref.watch(firebaseAuthServicesProvider);

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
            onPressed: () => _confirmSignOut(context, firebaseAuthServices),
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
