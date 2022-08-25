import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:io' as Io;

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testadmob/image_store/shared_preference.dart';

class ImageController extends GetxController {
  File? pickedImageFile;
  RxList bytesCode = [].obs;
  RxList encodedd = [].obs;
  var seletedImagePath = ''.obs;

  void pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    // final pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      pickedImageFile = File(pickedImage.path);
      final bytes = Io.File(pickedImageFile!.path).readAsBytesSync();
      String img64 = base64Encode(bytes);
      AppPreference.setString("image", img64);
      // List<int> imageBytes = pickedImageFile!.readAsBytesSync();
      // String base64Image = base64Encode(imageBytes);
      print("imagePath-->$pickedImageFile");
      log("imagePath-->$img64");
      /*for (var e in result.files) {
        bytesCode.add(File(e.path.toString()).readAsBytesSync());
        log("==${e.path.toString()}");
      }

      for (var e in bytesCode) {
        encodedd.add(base64Encode(e));
        log("-----imagePath-------${base64Encode(e)}");
      }*/
    }

    update();
  }

  /* File? image;
  String? imagePath;
  final _picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path;
      imagePath = pickedFile.path;
      print("imagePath-->$imagePath");
      update();
    } else {
      print('No image selected.');
    }
  }*/
}
