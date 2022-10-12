import 'dart:convert';
import 'dart:developer';
import 'dart:io' as Io;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testadmob/image_store/shared_preference.dart';
import 'package:testadmob/tirp/shared_preference.dart';

class ImageController extends GetxController {
  RxList bytesCode = [].obs;
  RxList encodedd = [].obs;
  var seletedImagePath = ''.obs;

  void pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickMultiImage(
        // source: ImageSource.gallery,

        );

    // final pickedImage = await picker.pickImage(source: ImageSource.camera);

    Future<List<String>> uploadFiles(List _images) async {
      List<String> imagesUrls = [];

      _images.forEach((_image) async {
        Reference storageReference = FirebaseStorage.instance.ref().child('posts/${_image.path}');
        UploadTask uploadTask = storageReference.putFile(_image);
        await uploadTask;

        imagesUrls.add(await storageReference.getDownloadURL());
      });
      print(imagesUrls);
      return imagesUrls;
    }

    if (pickedImage != null) {
      seletedImagePath.value = pickedImage.length as String;
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
