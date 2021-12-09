import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_flutter_register_login_firebase/pages/drawer/drawer_page.dart';
import 'package:riverpod_flutter_register_login_firebase/providers/providers.dart';
import 'package:riverpod_flutter_register_login_firebase/constants/keys.dart';
import 'package:riverpod_flutter_register_login_firebase/constants/commen_strings.dart';
import 'package:riverpod_flutter_register_login_firebase/services/firebase_auth_services.dart';
import 'package:riverpod_flutter_register_login_firebase/widgets/alerts/alert_dialogs.dart';
import 'package:riverpod_flutter_register_login_firebase/widgets/avatar/avatar.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.accountPage),
      ),
      drawer: const SafeArea(child: DrawerPage()),
    );
  }
}
