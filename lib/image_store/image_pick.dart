import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:images_picker/images_picker.dart';
import 'package:testadmob/app_open_ad_manager.dart';
import 'package:testadmob/image_store/image_controller.dart';
import 'package:testadmob/image_store/show_image.dart';

class ImagePick extends StatefulWidget {
  const ImagePick({Key? key}) : super(key: key);

  @override
  State<ImagePick> createState() => _ImagePickState();
}

class _ImagePickState extends State<ImagePick> with WidgetsBindingObserver {
  final ImageController imageController = Get.put(ImageController());
  String? path;
  AppOpenAd? myAppOpenAd;
  bool isPaused = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // AppOpenAdManager.loadAd();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      isPaused = true;
      print("user go to background");
    }
    if (state == AppLifecycleState.resumed && isPaused) {
      print("State Resumed===========");
      AppOpenAdManager.showOpenAdIfAvailable();
      isPaused = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 80),
          GestureDetector(
            onTap: () => {
              // _onPictureSelection()

              getImage()
            },
            child: Obx(
              () => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200,
                  width: 250,
                  child: imageController.seletedImagePath.value == null
                      ? SizedBox()
                      : Image.file(
                          File(imageController.seletedImagePath.value),
                          fit: BoxFit.cover,
                        ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.0,
                      color: Colors.grey,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Get.to(() => ShowImage());
              },
              child: Text("next")),
          ElevatedButton(
            child: const Text('pick'),
            onPressed: () async {
              print("error-----0");

              try {
                print("error-----1");

                await ImagesPicker.pick(
                  count: 3,
                  pickType: PickType.all,
                  language: Language.System,
                  maxTime: 30,
                  cropOpt: CropOption(
                    cropType: CropType.circle,
                  ),
                );
                print("error-----3");
              } catch (e) {
                print("error---->>$e");
              }
              // print(res);
              // if (res != null) {
              //   print(res.map((e) => e.path).toList());
              //   setState(() {
              //     path = res[0].thumbPath;
              //   });
              //   // bool status = await ImagesPicker.saveImageToAlbum(File(res[0]?.path));
              //   // print(status);
              // }
            },
          ),
        ],
      ),
    );
  }

  Future getImage() async {
    List<Media>? res = await ImagesPicker.pick(
      count: 3,
      pickType: PickType.image,
    );
    log("res----${res.toString()}");
  }

  _onPictureSelection() async {
    // imageController.pickImage();
  }
}
