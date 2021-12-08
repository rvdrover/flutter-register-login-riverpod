import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_flutter_register_login_firebase/providers/providers.dart';
import 'package:riverpod_flutter_register_login_firebase/constants/keys.dart';
import 'package:riverpod_flutter_register_login_firebase/constants/commen_strings.dart';
import 'package:riverpod_flutter_register_login_firebase/services/firebase_auth_services.dart';
import 'package:riverpod_flutter_register_login_firebase/widgets/alerts/alert_dialogs.dart';
import 'package:riverpod_flutter_register_login_firebase/widgets/avatar/avatar.dart';
import 'package:riverpod_flutter_register_login_firebase/widgets/drawer/drawer_widget.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    final user = firebaseAuth.currentUser!;
    final firebaseAuthServices = ref.watch(firebaseAuthServicesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.accountPage),
        
      ),
      body: _buildUserInfo(user, context, firebaseAuthServices),
      drawer: SafeArea(child: DrawerWidget(avatarImage: Avatar(radius: 40,photoUrl: user.photoURL,
              borderColor: Colors.black54,
              borderWidth: 2.0,),)),
    );
  }

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

  Widget _buildUserInfo(User user, BuildContext context,
      FirebaseAuthServices firebaseAuthServices) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height-570,
      color: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
