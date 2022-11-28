import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sizer/sizer.dart';
import 'package:testadmob/Ads%20Helper/advertisement_controller.dart';
import 'package:testadmob/admanag.dart';
import 'package:testadmob/image_store/image_pick.dart';
import 'package:testadmob/net_conectivity.dart';
import 'package:testadmob/realtime_database/get_data_realtime.dart';
import 'package:testadmob/revers_coundown.dart';
import 'package:testadmob/stream/get_data.dart';
import 'package:testadmob/tirp/shared_preference.dart';

AppOpenAd? myAppOpenAd;
//
// void loadAppOpenAd() {
//   AppOpenAd.load(
//       adUnitId: "ca-app-pub-3940256099942544/3419835294", //Your ad Id from admob
//       request: const AdRequest(),
//       adLoadCallback: AppOpenAdLoadCallback(
//           onAdLoaded: (ad) {
//             myAppOpenAd = ad;
//             myAppOpenAd!.show();
//           },
//           onAdFailedToLoad: (error) {}),
//       orientation: AppOpenAd.orientationPortrait);
// }

Future<void> main() async {
  // print('main function call');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();
  final GoogleMapsFlutterPlatform mapsImplementation = GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
  }
  // loadAppOpenAd();
  await FirebaseRemoteConfigUtils().initMethod();
  await AppPreference.initMySharedPreferences();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AdvertisementController advertisementController = Get.put(AdvertisementController());

  @override
  void initState() {
    print("main file call");
    // AppOpenAdManager.loadAd();
    advertisementController.advertisementData();
    advertisementController.docsOfModel.bindStream(advertisementController.advertisementData());
    // firstTimeAdShow = true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
        return GetMaterialApp(
          builder: (_, w) => ConnectivityWidget(
            builder: (_, __) => BotToastInit()(_, w),
          ),
          debugShowCheckedModeBanner: false,
          home: UserListPage(),
        );
      },
    );
  }
}
