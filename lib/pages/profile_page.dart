import 'package:coinquilini/components/text_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagina profilo"),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 50,
            // IMG USER
          ),
          // EMAIL USER
          Text(
            currentUser.email!,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[700]),
          ),

          const SizedBox(height: 50),
          // DETTAGLI USER
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              'Dettagli',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),

          MyTextBox(
            text: 'okusersssssss',
            sectionName: 'username',
          ),
        ],
      ),
    );
  }
}
