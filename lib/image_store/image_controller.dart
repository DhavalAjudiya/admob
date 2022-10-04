import 'dart:convert';
import 'dart:developer';
import 'dart:io' as Io;

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testadmob/image_store/shared_preference.dart';

class ImageController extends GetxController {
  RxList bytesCode = [].obs;
  RxList encodedd = [].obs;
  var seletedImagePath = ''.obs;

  void pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );

    // final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      seletedImagePath.value = pickedImage.path;
      final bytes = Io.File(seletedImagePath.value).readAsBytesSync();
      String img64 = base64Encode(bytes);
      AppPreference.setString("image", img64);
      // List<int> imageBytes = pickedImageFile!.readAsBytesSync();
      // String base64Image = base64Encode(imageBytes);
      print("imagePath-->$seletedImagePath.value");
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
}
