import 'dart:typed_data';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coinquilini/components/text_box.dart';
import 'package:coinquilini/components/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Uint8List? _image;
  final currentUser = FirebaseAuth.instance.currentUser!;

  final usersCollection = FirebaseFirestore.instance.collection("Users");

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() => {_image = img});
  }

  // modifica campo
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Modifica $field",
          style: const TextStyle(color: Colors.green),
        ),
        content: TextField(
          autofocus: true,
          style: TextStyle(color: Colors.green),
          decoration: InputDecoration(
              hintText: "Modifica $field",
              hintStyle: TextStyle(color: Colors.grey[400])),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Annulla',
                style: TextStyle(color: Colors.grey[400]),
              )),
          TextButton(
              onPressed: () => Navigator.of(context).pop(newValue),
              child: Text(
                'Modifica',
                style: TextStyle(color: Colors.green),
              )),
        ],
      ),
    );

    if (newValue.trim().length > 0) {
      await usersCollection.doc(currentUser.email).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pagina profilo"),
          backgroundColor: Colors.green,
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(currentUser.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userData = snapshot.data!.data() as Map<String, dynamic>;

                return ListView(
                  children: [
                    const SizedBox(
                      height: 50,
                      // IMG USER
                    ),

                    Stack(
                      alignment: Alignment.center,
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 55,
                                backgroundImage: MemoryImage(_image!),
                              )
                            : CircleAvatar(
                                radius: 55,
                                backgroundImage: NetworkImage(
                                    'https://www.contentviewspro.com/wp-content/uploads/2017/07/default_image.png'),
                              ),
                        Positioned(
                            child: IconButton(
                                onPressed: selectImage,
                                icon: Icon(Icons.add_a_photo)))
                      ],
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
                      text: userData["Username"],
                      sectionName: 'Username',
                      onPressed: () => editField('Username'),
                    ),

                    // BIOGRAFIA USER
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, top: 20),
                      child: Text(
                        'Biografia',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),

                    MyTextBox(
                      text: userData["Bio"],
                      sectionName: 'Bio',
                      onPressed: () => editField('Bio'),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error${snapshot.error}'),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
