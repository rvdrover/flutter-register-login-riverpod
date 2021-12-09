import 'package:flutter/material.dart';
import 'package:riverpod_flutter_register_login_firebase/pages/drawer/drawer_page.dart';
import 'package:riverpod_flutter_register_login_firebase/constants/commen_strings.dart';

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
            icon: Container(
              width: 40,
              height: 40,
              child: const Icon(Icons.person),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
      drawer: const SafeArea(child: DrawerPage()),
    );
  }
}
