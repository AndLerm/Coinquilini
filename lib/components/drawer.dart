import 'package:coinquilini/components/my_list_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSignOut;
  final currentUser = FirebaseAuth.instance.currentUser!;

  MyDrawer({super.key, required this.onProfileTap, required this.onSignOut});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.green,
      child: Column(
        children: [
          // icona
          DrawerHeader(
              child: Icon(
            Icons.person,
            color: Colors.white,
            size: 60,
          )),

          Text((currentUser.email!)),

          // home
          MyListTile(
            icon: Icons.home,
            text: 'H O M E',
            onTap: () => Navigator.pop(context),
          ),

          // profilo
          MyListTile(
            icon: Icons.person,
            text: 'P R O F I L O',
            onTap: onProfileTap,
          ),

          // logout
          MyListTile(
            icon: Icons.exit_to_app,
            text: 'L O G O U T',
            onTap: onSignOut,
          ),
        ],
      ),
    );
  }
}
