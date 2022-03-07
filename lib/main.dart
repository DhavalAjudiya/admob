import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:testadmob/googlead.dart';
import 'package:testadmob/home.dart';
import 'admob_flutter.dart';
import 'firebase_core.dart';

AppOpenAd? openAd;

Future<void> loadAd() async {
  await AppOpenAd.load(
    adUnitId: "ca-app-pub-7556725778661360~3114775001",
    request: AdRequest(),
    adLoadCallback: AppOpenAdLoadCallback(
      onAdLoaded: (oad) {
        print("open ad");
        openAd = oad;
        // openAd!.show();
      },
      onAdFailedToLoad: (error) {
        print("error open $error");
      },
    ),
    orientation: AppOpenAd.orientationPortrait,
  );
}

void showOpenAd() {
  if (openAd == null) {
    print("try to loading");
    loadAd();
    return;
  }

  openAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {},
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        openAd = null;
        loadAd();
      },
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        openAd = null;
        loadAd();
      });
  openAd!.show();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await loadAd();
  showOpenAd();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
