import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter_register_login_firebase/pages/drawer/drawer_page.dart';
import 'package:riverpod_flutter_register_login_firebase/constants/commen_strings.dart';
import 'package:riverpod_flutter_register_login_firebase/providers/sign_in_provider/sign_in_provider.dart';
import 'package:riverpod_flutter_register_login_firebase/widgets/avatar/avatar.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.accountPage),
        leading: Builder(
          builder: (context) => IconButton(
            splashRadius: 30,
            iconSize: 30,
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Consumer(builder: (context, ref, _) {
              final firebaseAuth = ref.watch(firebaseAuthProvider);
              final user = firebaseAuth.currentUser!;
              return Avatar(
                photoUrl: user.photoURL,
                radius: 20,
                borderWidth: 1,
                borderColor: Colors.white,
              );
            }),
          ),
        ),
      ),
      drawer: const SafeArea(child: DrawerPage()),
    );
  }
}
