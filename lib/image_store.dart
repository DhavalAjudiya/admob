import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ImageStore extends StatefulWidget {
  const ImageStore({Key? key}) : super(key: key);

  @override
  State<ImageStore> createState() => _ImageStoreState();
}

class _ImageStoreState extends State<ImageStore> {
  firebase_storage.FirebaseStorage kFirebaseStorage =
      firebase_storage.FirebaseStorage.instance;
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() async {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        // uploadFile(file, filename);
        print("image path ----$_image");
      } else {
        print('No image selected.');
      }
    });
  }

  Future<String?> uploadFile(File file, String filename) async {
    print("File path:${file.path}");
    try {
      var response =
          await kFirebaseStorage.ref("user_image/$filename").putFile(file);
      return response.storage.ref("user_image/$filename").getDownloadURL();
    } on firebase_storage.FirebaseException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              getImage();
              uploadFile(_image!, "image.jpg");
            },
            child: Text('ADD'),
          ),
        ],
      ),
    );
  }
}
