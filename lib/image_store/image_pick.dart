import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testadmob/image_store/image_controller.dart';
import 'package:testadmob/image_store/show_image.dart';

class ImagePick extends StatefulWidget {
  const ImagePick({Key? key}) : super(key: key);

  @override
  State<ImagePick> createState() => _ImagePickState();
}

class _ImagePickState extends State<ImagePick> {
  final ImageController imageController = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 80),
          GestureDetector(
            onTap: () => {_onPictureSelection()},
            child: Container(
              height: 100,
              width: 250,
              child: imageController.pickedImageFile == null
                  ? SizedBox()
                  : Image.file(
                      File("${imageController.pickedImageFile}"),
                    ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3.0,
                  color: Colors.grey,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Get.to(ShowImage());
              },
              child: Text("next")),
        ],
      ),
    );
  }

  _onPictureSelection() async {
    imageController.pickImage();
  }
}
