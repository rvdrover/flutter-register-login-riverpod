import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter_register_login_firebase/constants/commen_strings.dart';
import 'package:riverpod_flutter_register_login_firebase/providers/providers.dart';
import 'package:riverpod_flutter_register_login_firebase/services/firebase_auth_services.dart';
import 'package:riverpod_flutter_register_login_firebase/widgets/alerts/alert_dialogs.dart';

import 'package:riverpod_flutter_register_login_firebase/widgets/avatar/avatar.dart';

class DrawerPage extends ConsumerWidget {
  const DrawerPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    final user = firebaseAuth.currentUser!;
    final firebaseAuthServices = ref.watch(firebaseAuthServicesProvider);
    return Drawer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        createHeader(user),
        Expanded(
          child: ListView(
            children: [
              // ListTile(
              //   title: const Text('0.0.1'),
              //   onTap: () {},
              // ),
              themeToggle(),
              createDrawerItem(
                  icon: Icons.more_horiz, text: 'More', onTap: () => {}),
            ],
          ),
        ),
        const Divider(
          thickness: 1,
        ),
        createDrawerItem(
          icon: Icons.logout,
          text: 'Logout',
          onTap: () => _confirmSignOut(context, firebaseAuthServices),
        ),
      ],
    ));
  }
}


Widget createHeader(User user) {
  return DrawerHeader(
    margin: EdgeInsets.zero,
    padding: EdgeInsets.zero,
    decoration: const BoxDecoration(
      color: Colors.blueAccent,
    ),
    child: Stack(
      children: [
        Positioned(
          left: 10,
          top: 20,
          child: Column(
            children: [
              Avatar(
                radius: 40,
                photoUrl: user.photoURL,
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
          ),
        )
      ],
    ),
  );
}

Widget createDrawerItem(
    {IconData? icon, String? text, GestureTapCallback? onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(text!),
        )
      ],
    ),
    onTap: onTap,
  );
}

Widget themeToggle({IconData? icon, String? text, GestureTapCallback? onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        ActionChip(
          label: const Text("Lights On"),
          onPressed: () {},
          avatar: const Icon(Icons.brightness_5),
        )
      ],
    ),
    onTap: onTap,
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