import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
  if (file != null) {
    return await file.readAsBytes();
  }
  print('Nessuna immagine selezionata');
}

// ImagePicker imagePicker=ImagePicker();
// Xfile? file = await imagePicker.pickImage(source: ImageSource.camera);
// print ('${file?.path}')

// Reference referenceRoot = FirebaseStorage.instance.ref();

// Reference referenceDirImages = referenceRoot.child('images');

// Reference referenceImageToUpload=referenceDirImages.child('');