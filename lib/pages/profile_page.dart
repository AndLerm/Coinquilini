import 'dart:typed_data';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coinquilini/components/add_data.dart';
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
    setState(() => _image = img);
  }

  void saveProfile() async {
    String resp = await StoreData().saveData(file: _image!);
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
          style: const TextStyle(color: Colors.green),
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
              child: const Text(
                'Modifica',
                style: TextStyle(color: Colors.green),
              )),
        ],
      ),
    );

    if (newValue.trim().isNotEmpty) {
      await usersCollection.doc(currentUser.email).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profilo"),
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
                            : const CircleAvatar(
                                radius: 55,
                                backgroundColor: Colors.white30,
                                backgroundImage: AssetImage(
                                  'lib/images/C1.png',
                                ),
                              ),
                        Positioned(
                            child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(Icons.add_a_photo),
                          padding: const EdgeInsets.only(top: 80, left: 100),
                        ))
                      ],
                    ),

                    // EMAIL USER
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 15),
                      child: Text(
                        (currentUser.email!.split('@')[0]),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.green,
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ),
                    ),

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
                      sectionName: '',
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
                      sectionName: '',
                      onPressed: () => editField('Bio'),
                    ),

                    ElevatedButton(
                      onPressed: saveProfile,
                      child: const Text('Save'),
                    )
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
