import 'package:flutter/material.dart';

import 'package:riverpod_flutter_register_login_firebase/widgets/avatar/avatar.dart';

class DrawerWidget extends StatelessWidget {
  final Avatar avatarImage;
  const DrawerWidget({
    Key? key,
    required this.avatarImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: <Widget>[
        createHeader(avatarImage),
        createDrawerItem(icon: Icons.logout, text: 'Logout', onTap: () {}),
        ListTile(
          title: const Text('0.0.1'),
          onTap: () {},
        ),
      ],
    ));
  }
}

Widget createHeader(Avatar avatarImage) {
  return DrawerHeader(
    margin: EdgeInsets.zero,
    padding: EdgeInsets.zero,
    decoration: const BoxDecoration(
      color: Colors.blueAccent,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        avatarImage,
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
