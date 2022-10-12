import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sizer/sizer.dart';
import 'package:testadmob/admanag.dart';
import 'package:testadmob/app_open_ad_manager.dart';
import 'package:testadmob/net_conectivity.dart';
import 'package:testadmob/syncfusion/pichart.dart';
import 'package:testadmob/image_store/image_pick.dart';
import 'package:testadmob/image_store/shared_preference.dart';
import 'package:testadmob/syncfusion/syncfusion_home.dart';
import 'package:testadmob/tirp/shared_preference.dart';
import 'package:testadmob/tirp/trip_page.dart';

AppOpenAd? myAppOpenAd;

void loadAppOpenAd() {
  AppOpenAd.load(
      adUnitId: "ca-app-pub-3940256099942544/3419835294", //Your ad Id from admob
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
          onAdLoaded: (ad) {
            myAppOpenAd = ad;
            myAppOpenAd!.show();
          },
          onAdFailedToLoad: (error) {}),
      orientation: AppOpenAd.orientationPortrait);
}

Future<void> main() async {
  // print('main function call');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();
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
  @override
  void initState() {
    print("main file call");
    // AppOpenAdManager.loadAd();
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
          home: TripPage(),
        );
      },
    );
  }
}
