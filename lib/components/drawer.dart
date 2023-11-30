import 'dart:typed_data';

import 'package:coinquilini/components/my_list_tile.dart';
import 'package:coinquilini/components/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyDrawer extends StatefulWidget {
  final void Function()? onProfileTap;
  final void Function()? onSignOut;

  MyDrawer({super.key, required this.onProfileTap, required this.onSignOut});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  Uint8List? _image;

  final currentUser = FirebaseAuth.instance.currentUser!;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() => _image = img);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 55,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : const CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.white30,
                            backgroundImage: AssetImage(
                              'lib/images/C1.png',
                            ),
                          ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Text(
                  (currentUser.email!.split('@')[0]),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
              ),

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
                onTap: widget.onProfileTap,
              ),
            ],
          ),
          // icona

          // logout
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyListTile(
              icon: Icons.exit_to_app,
              text: 'L O G O U T',
              onTap: widget.onSignOut,
            ),
          ),
        ],
      ),
    );
  }
}
