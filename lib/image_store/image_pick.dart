import 'dart:developer';
import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:images_picker/images_picker.dart';
import 'package:intl/intl.dart';
import 'package:testadmob/app_open_ad_manager.dart';
import 'package:testadmob/image_store/image_controller.dart';

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
  bool isShowAd = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // convertSimpleDayFormat();
    print("dateNow--------dateNow-${DateTime.now().millisecondsSinceEpoch}");

    DateTime displayTime = DateTime.fromMillisecondsSinceEpoch(1665126935004);

    final String dateNow = DateFormat.EEEE().format(displayTime);
    // dateNow1 = dateNow / 86400000;
    // if(dateNow == ){
    //
    // }
    print("dateNow---------$dateNow");
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
          // Stack(
          //   clipBehavior: Clip.none,
          //   children: [
          //     isShowAd == true
          //         ? Container(
          //             decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(10)),
          //             child: Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 2),
          //               child: Column(
          //                 children: [
          //                   Container(
          //                     decoration: const BoxDecoration(
          //                       image: DecorationImage(
          //                         image: AssetImage(
          //                           "asset/image/loud.gif",
          //                         ),
          //                         fit: BoxFit.cover,
          //                       ),
          //                     ),
          //                     width: 100,
          //                     height: 80,
          //                   ),
          //                   const Text("Loading..."),
          //                 ],
          //               ),
          //             ),
          //           )
          //         : ElevatedButton(
          //             onPressed: () {
          //               print("---Future-delayed----Before---");
          //               // dealt();
          //               isShowAd = true;
          //               setState(() {});
          //               Future.delayed(Duration(seconds: 5), () {
          //                 isShowAd = false;
          //                 setState(() {});
          //                 // Get.to(() => ShowImage());
          //                 print("---Future-delayed----After---");
          //               });
          //             },
          //             child: const Text("next")),
          //   ],
          // ),
          GestureDetector(
            child: const Text('pickDate'),
            onTap: () {
              print("pickDate-------onChanged------");

              try {
                dateTimePicker(onChanged: (val) {
                  print("pickDate-------onChanged-----1-$val");
                });
              } catch (e) {
                print("pickDate-------error-------$e");
              }
              // dateTimeFormat();
              // print("error-----0");
              //
              // try {
              //   print("error-----1");
              //
              //   await ImagesPicker.pick(
              //     count: 3,
              //     pickType: PickType.all,
              //     language: Language.System,
              //     maxTime: 30,
              //     cropOpt: CropOption(
              //       cropType: CropType.circle,
              //     ),
              //   );
              //   print("error-----3");
              // } catch (e) {
              //   print("error---->>$e");
              // }
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
          ElevatedButton(
            child: const Text('pick'),
            onPressed: () async {
              // dateTimeFormat();
              // print("error-----0");
              //
              // try {
              //   print("error-----1");
              //
              //   await ImagesPicker.pick(
              //     count: 3,
              //     pickType: PickType.all,
              //     language: Language.System,
              //     maxTime: 30,
              //     cropOpt: CropOption(
              //       cropType: CropType.circle,
              //     ),
              //   );
              //   print("error-----3");
              // } catch (e) {
              //   print("error---->>$e");
              // }
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

  Widget dateTimePicker({required ValueChanged<String>? onChanged}) {
    return DateTimePicker(
      initialValue: '',
      decoration: const InputDecoration(
        isDense: true,
        // suffixIcon: Image.asset(
        //   IconsAsset.dateAndTime,
        //   scale: 3,
        // ),
        counterText: "",
        // hintText: hintText,
        // hintStyle: TextStyle(
        //   color: AppColors.textColor,
        //   fontSize: SizeUtils.fSize_14(),
        //   fontWeight: FontWeight.w400,
        // ),
        filled: true,
        // fillColor: AppColors.white,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          // borderSide: BorderSide(color: AppColors.white[80]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          // borderSide: BorderSide(color: AppColors.white[80]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          // borderSide: BorderSide(color: AppColors.white[80]!),
        ),
      ),
      type: DateTimePickerType.dateTime,
      dateMask: 'd MMMM, yyyy - hh:mm a',
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      timeLabelText: "Hour",
      onChanged: onChanged,
    );
  }

  // if (!homeController.isTap.value) {
  //   homeController.isTap.value = true;
  //   print("${homeController.isTap.value}");
  //   Future.delayed(Duration(seconds: 2)).whenComplete(
  //     () {
  //       homeController.isTap.value = false;
  //       print("${homeController.isTap.value}");
  //     },
  //   );
  // }
  String dateTimeFormat(DateTime dt) {
    DateTime now = DateTime.now();
    int days = DateTime(dt.year, dt.month, dt.day).difference(DateTime(now.year, now.month, now.day)).inDays;
    if (days == 0) {
      return "Today";
    } else if (days == -1) {
      return "Yesterday";
    } else {
      return DateFormat("yyy.MM.dd").format(dt);
    }
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

  static String convertSimpleDayFormat() {
    int displayTime = DateTime.fromMillisecondsSinceEpoch(05575665464) as int;
    log("displayTime----int-----${displayTime.toString()}");

    displayTime = (displayTime / 86400000) as int;
    log("displayTime----int-----${displayTime.toString()}");

    String displayTimeVal = "";
    if (displayTime < 1) {
      displayTimeVal = "today";
      log("displayTime----today---${displayTime.toString()}");
    } else if (displayTime < 2) {
      displayTimeVal = "yesterday";
      log("displayTime----yesterday---${displayTime.toString()}");
    } else if (displayTime < 7) {
      displayTimeVal = "last7days";
      log("displayTime----last7days---${displayTime.toString()}");
    } else if (displayTime < 30) {
      displayTimeVal = "last30days";
      log("displayTime----last30days---${displayTime.toString()}");
    } else {
      displayTimeVal = "morethan30days";
      log("displayTime----morethan30days---${displayTime.toString()}");
    }
    return displayTimeVal;
  }

// static String timeAgoSinceDate(int milliSecond) {
//   //week 1646110200000 Tue Mar 01 2022 04:50:00
//   //days 1646455800000 Sat Mar 05 2022 04:50:00
//   //year 1614919800000 Fri Mar 05 2021 04:50:00
//   //month 1644382200000  9-2-2022
//   DateTime date = DateTime.fromMillisecondsSinceEpoch(milliSecond);
//   final date2 = DateTime.now();
//   final difference = date2.difference(date);
//   final duration = Duration(days: date.day, hours: date.hour, minutes: date.minute, seconds: date.second);
//   var hours = date2.subtract(duration).hour;
//   var minutes = date2.subtract(duration).minute;
//   if ((difference.inDays / 365).floor() >= 1) {
//     return "${(difference.inDays / 365).floor()}Y ${hours}H ${minutes}m";
//   } else if ((difference.inDays / daysInMonth(monthNum: date.month, year: date.year)).floor() >= 1) {
//     return "${(difference.inDays / daysInMonth(monthNum: date.month, year: date.year)).floor()}M ${hours}H ${minutes}m";
//   } else if ((difference.inDays / 7).floor() >= 1) {
//     return "${(difference.inDays / 7).floor()}W ${hours}H ${minutes}m";
//   } else if ((difference.inDays).floor() >= 1) {
//     return '${(difference.inDays).floor()}D ${hours}H ${minutes}m';
//   } else if (difference.inHours >= 1) {
//     return '${difference.inHours}H ${minutes}s';
//   } else if (difference.inMinutes >= 1) {
//     return '${difference.inMinutes}m';
//   } else {
//     return '${difference.inSeconds}s';
//   }
// }
}
